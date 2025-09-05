{% set label_accent_classes = 'label label-accent' %}

{{ component(
  'labels', {
    prioritize_promotion_over_offer: true,
    promotion_nxm_long_wording: false,
    promotion_quantity_long_wording: true,
    labels_classes: {
      group: 'js-labels-floating-group ' ~ (product_detail ? 'labels-product-slider'),
      promotion: label_accent_classes,
      promotion_primary_text: 'd-block',
      offer: 'js-offer-label ' ~ label_accent_classes,
      shipping: label_accent_classes,
      no_stock: 'js-stock-label label label-default',
    },
  })
}}