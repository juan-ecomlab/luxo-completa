<script>
/* TNX Preload v1.0 — paste inside <script> in <head> */
(function() {
  var STORE_ID = '{{STORE_ID}}';
  var API = '{{API_ENDPOINT}}';
  var CACHE_TTL = 5 * 60 * 1000;

  try { if (new URLSearchParams(location.search).get('tnx_visual_editor') === 'true') return; } catch(e) {}

  // Visitor ID — same localStorage key as tnx-core
  var visitorId;
  try {
    var s = localStorage.getItem('tnx_visitor_id');
    if (s) { var d = JSON.parse(s); if (Date.now() - d.created < 365*24*60*1000) visitorId = d.id; }
  } catch(e) {}
  if (!visitorId) {
    visitorId = 'visitor_' + Date.now() + '_' + Math.random().toString(36).substr(2, 12);
    try { localStorage.setItem('tnx_visitor_id', JSON.stringify({ id: visitorId, created: Date.now() })); } catch(e) {}
  }

  // Assignment cache (sessionStorage)
  var cached = null;
  try {
    var raw = sessionStorage.getItem('tnx_preload_cache');
    if (raw) { var c = JSON.parse(raw); if (Date.now() - c.ts < CACHE_TTL && c.sid === STORE_ID) cached = c.data; }
  } catch(e) {}

  // URL matching (same as tnx-core)
  function matchUrl(path, pattern) {
    if (!pattern || pattern === '/*' || pattern === '*') return true;
    if (pattern === path) return true;
    if (pattern.endsWith('/*')) return path.startsWith(pattern.slice(0, -2));
    if (pattern.indexOf('*') !== -1) return path.startsWith(pattern.slice(0, -1));
    try { return new RegExp('^' + pattern + '$').test(path); } catch(e) { return false; }
  }

  function filterByUrl(exps) {
    var path = location.pathname;
    return exps.filter(function(exp) {
      var p = (exp.targeting || {}).url_patterns || '*';
      if (!p || p.trim() === '' || p === '*') return true;
      return p.split(',').some(function(s) { return matchUrl(path, s.trim()); });
    });
  }

  // Modification application (same as tnx-core)
  function toCamel(s) { return s.replace(/-([a-z])/g, function(m,l) { return l.toUpperCase(); }); }

  function applyAction(el, a) {
    try {
      if (a.type === 'css' && a.properties) {
        Object.keys(a.properties).forEach(function(p) { el.style[toCamel(p)] = a.properties[p]; });
      } else if (a.type === 'attribute' && a.name) {
        el.setAttribute(a.name, a.value);
      } else if (a.type === 'class' && a.className) {
        el.classList[a.operation](a.className);
      } else if (a.type === 'content' && a.value !== undefined) {
        if (a.mode === 'text') el.textContent = a.value; else if (a.mode === 'html') el.innerHTML = a.value;
      } else if (a.type === 'remove') {
        if (a.mode === 'hide') el.style.display = 'none'; else if (a.mode === 'remove') el.remove();
      }
    } catch(e) {}
  }

  function observeFor(selector, cb) {
    var done = false;
    var obs = new MutationObserver(function() {
      try {
        var els = document.querySelectorAll(selector);
        if (els.length > 0) { done = true; obs.disconnect(); els.forEach(cb); }
      } catch(e) {}
    });
    obs.observe(document.body || document.documentElement, { childList: true, subtree: true });
    setTimeout(function() { if (!done) obs.disconnect(); }, 10000);
  }

  function applyMods(mods) {
    var path = location.pathname;
    mods.forEach(function(mod) {
      if (!mod.actions || !mod.selector) return;
      if (!matchUrl(path, mod.urlPattern || '/*')) return;
      try {
        var els = document.querySelectorAll(mod.selector);
        if (els.length > 0) {
          els.forEach(function(el) { mod.actions.forEach(function(a) { applyAction(el, a); }); });
        } else {
          observeFor(mod.selector, function(el) { mod.actions.forEach(function(a) { applyAction(el, a); }); });
        }
      } catch(e) {}
    });
  }

  function applyToggle(cfg, variant) {
    var path = location.pathname;
    var hideRules = [];
    (cfg.elements_to_hide || []).forEach(function(item) {
      if (!matchUrl(path, item.urlPattern || '/*') || item.hideIn !== variant) return;
      hideRules.push(item.selector);
    });
    if (hideRules.length === 0) return;
    var s = document.createElement('style');
    s.id = 'tnx-hide-rules';
    s.textContent = hideRules.map(function(sel) { return sel + ' { display: none !important; }'; }).join('');
    (document.head || document.documentElement).appendChild(s);
  }

  function applyInsert(cfg, variant) {
    if (variant !== 'treatment') return;
    var path = location.pathname;
    (cfg.elements_to_insert || []).forEach(function(item) {
      if (!matchUrl(path, item.urlPattern || '/*')) return;
      var doInsert = function(el) {
        var iid = item.selector + '::' + item.position + '::' + item.html.length;
        if (el.parentNode.querySelector('[data-tnx-insert-id="' + iid + '"]')) return;
        var w = document.createElement('span');
        w.setAttribute('data-tnx-insert-id', iid);
        w.innerHTML = item.html;
        el.insertAdjacentElement(item.position, w);
      };
      try {
        var els = document.querySelectorAll(item.selector);
        if (els.length > 0) { els.forEach(doInsert); } else { observeFor(item.selector, doInsert); }
      } catch(e) {}
    });
  }

  // Anti-flicker — injected in <head> before body parses, elements born hidden
  var afStyle = null;
  function hideSelectors(exps) {
    var sels = [];
    exps.forEach(function(exp) {
      var c = exp.config || {};
      if (c.modifications) c.modifications.forEach(function(m) { if (m.selector) sels.push(m.selector); });
      if (c.elements_to_hide) c.elements_to_hide.forEach(function(h) { if (h.selector) sels.push(h.selector); });
    });
    if (!sels.length) return;
    afStyle = document.createElement('style');
    afStyle.id = 'tnx-preload-af';
    afStyle.textContent = sels.map(function(s) { return s + '{opacity:0!important;transition:none!important}'; }).join('');
    (document.head || document.documentElement).appendChild(afStyle);
  }
  function showAll() { if (afStyle) { try { afStyle.remove(); } catch(e) {} afStyle = null; } }
  setTimeout(showAll, 800);

  // Apply all experiments
  function applyAll(exps) {
    exps.forEach(function(exp) {
      var c = exp.config;
      if (!c) return;
      if (c.modifications) applyMods(c.modifications);
      if (c.elements_to_hide) applyToggle(c, exp.variant);
      if (c.elements_to_insert) applyInsert(c, exp.variant);
      try { sessionStorage.setItem('tnx_current_exp', exp.id); sessionStorage.setItem('tnx_current_var', exp.variant); } catch(e) {}
    });
    showAll();
  }

  // DOM readiness
  var domReady = document.readyState !== 'loading';
  var readyQueue = [];
  function onReady(fn) { if (domReady) fn(); else readyQueue.push(fn); }
  if (!domReady) document.addEventListener('DOMContentLoaded', function() {
    domReady = true; readyQueue.forEach(function(fn) { fn(); }); readyQueue = [];
  });

  // Main flow
  function process(exps) {
    var filtered = filterByUrl(exps);
    if (!filtered.length) return;
    hideSelectors(filtered);
    onReady(function() { applyAll(filtered); });
  }

  if (cached) {
    process(cached);
  } else {
    fetch(API + '/api/assignments?store_id=' + encodeURIComponent(STORE_ID) +
      '&visitor_id=' + encodeURIComponent(visitorId) +
      '&ua=' + encodeURIComponent(navigator.userAgent), { credentials: 'omit' })
    .then(function(r) { return r.json(); })
    .then(function(data) {
      var exps = (data.data && data.data.experiments) || data.experiments || [];
      try { sessionStorage.setItem('tnx_preload_cache', JSON.stringify({ data: exps, ts: Date.now(), sid: STORE_ID })); } catch(e) {}
      process(exps);
    })
    .catch(function() { showAll(); });
  }
})();
</script>
