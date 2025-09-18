# Mobile Size Selector Implementation Plan

## Goal
Move the size selector below the price on mobile devices while keeping the overlay behavior on desktop, as shown in the reference image.

## Current State
- Size selector works as floating overlay on hover
- Positioned within `item-floating-elements` 
- Uses vanilla JS for add-to-cart functionality
- Works well on desktop but needs mobile-specific positioning

## Implementation Strategy

### 1. Template Changes (`snipplets/grid/item.tpl`)
- Add a mobile-specific size selector container in the item description area
- Position it after the price container (`item-price-container`) using responsive classes
- Keep existing floating overlay for desktop with `d-none d-md-block`

### 2. Size Selector Component (`snipplets/grid/item-sizes.tpl`)  
- Add a `mobile_version` parameter to render different layouts
- Mobile version: simplified horizontal layout without overlay styling
- Desktop version: current floating overlay implementation

### 3. CSS Responsive Styles (`static/css/style-critical.scss`)
- Hide floating overlay on mobile: 
  ```scss
  .item-floating-elements .item-sizes-container { 
    @media (max-width: 767px) { 
      display: none !important; 
    } 
  }
  ```
- Style mobile version: horizontal layout, proper spacing below price
- Ensure touch-friendly button sizes for mobile (minimum 44px touch targets)

### 4. JavaScript Behavior (`static/js/store.js.tpl`)
- Update selectors to work with both mobile and desktop versions
- Maintain same add-to-cart functionality for both instances
- Consider removing hover triggers on mobile (touch devices don't have hover)

### 5. Testing Approach
- Verify both versions work independently
- Test add-to-cart functionality on both mobile and desktop
- Ensure responsive breakpoints work correctly (Bootstrap's md breakpoint: 768px)
- Validate touch interactions on mobile devices

## Implementation Options

### Option A: Template Duplication (Recommended)
- Create two size selector instances (one for mobile, one for desktop)
- Use responsive classes to show/hide appropriately
- Simpler implementation, clear separation
- Easier to maintain different behaviors

### Option B: Dynamic Repositioning
- Use JavaScript to move the size selector based on screen size
- More complex but avoids code duplication
- Risk of layout shifts during repositioning

### Option C: CSS-Only Responsive Layout
- Use media queries to reposition the same size selector
- Cleanest approach but may have positioning limitations
- Difficult to achieve the desired mobile layout from floating overlay

## Files to Modify
1. `snipplets/grid/item.tpl` - Add mobile size selector container
2. `snipplets/grid/item-sizes.tpl` - Add mobile version parameter/logic
3. `static/css/style-critical.scss` - Add mobile-specific styles
4. `static/js/store.js.tpl` - Ensure compatibility with both versions

## Mobile-Specific Considerations
- Touch-friendly button sizes (44x44px minimum)
- No hover state needed - use active/focus states instead
- Clear visual separation from price and other elements
- Ensure it doesn't interfere with scrolling or other touch interactions
- Consider showing size selector by default (no trigger needed)

## Reference Design
Based on the provided image showing the size selector positioned horizontally below the price information on mobile, maintaining the same button styling but in a different layout context.

## Next Steps
1. Implement Option A (template duplication) 
2. Add mobile container in item description area
3. Create responsive CSS rules
4. Test on both desktop and mobile devices
5. Validate add-to-cart functionality across both versions