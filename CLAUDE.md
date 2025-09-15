# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Luxo** theme for Nuvemshop/TiendaNube, a Latin American e-commerce platform. The theme is a complete, production-ready solution with modern web development practices adapted for the platform's template system.

## Architecture

### Template System
- **Template Files**: `.tpl` files using Nuvemshop's proprietary template syntax (Twig-like)
- **Layouts**: Main layout in `/layouts/layout.tpl`
- **Page Templates**: In `/templates/` (home, product, category, cart, account, etc.)
- **Reusable Components**: In `/snipplets/` organized by functionality (header, footer, home, product, grid, navigation, forms, svg)

### Styling Architecture
The theme uses a three-tier CSS system optimized for performance:
- **Critical CSS** (`static/style-critical.scss`): Above-the-fold styles, inlined in layout
- **Async CSS** (`static/style-async.scss`): Non-critical styles, loaded asynchronously
- **Color System** (`static/style-colors.scss`): Dynamic theme colors from settings

### Configuration System
- `config/settings.txt`: Theme customization options (colors, fonts, layout settings)
- `config/defaults.txt`: Default values for all theme settings
- `config/translations.txt`: Multi-language support (es, en, pt, es_mx)
- `config/data.json`: Build configuration and asset management

## Development Workflow

### No Traditional Build System
This project doesn't use npm, webpack, or similar build tools. The Nuvemshop platform handles:
- SCSS compilation
- JavaScript processing
- Template compilation
- Asset optimization

### Key File Types
- `.tpl`: Template files with Nuvemshop template syntax
- `.scss`: SCSS stylesheets (compiled by platform)
- `.js`: JavaScript files (processed by platform)
- `.txt`: Configuration files

### Theme Structure
```
├── config/           # Theme configuration
├── layouts/          # Base layout template
├── templates/        # Page-specific templates
├── snipplets/        # Reusable components
│   ├── header/      # Navigation and header elements
│   ├── footer/      # Footer components
│   ├── home/        # Homepage sections
│   ├── product/     # Product detail components
│   ├── grid/        # Product listings and filters
│   ├── forms/       # Form components
│   └── svg/         # Icon components
├── static/          # CSS and JS assets
└── assets/          # Additional CSS files
```

## Template System Conventions

### Component Organization
- Components are organized by feature area in `/snipplets/`
- Each component includes its own styling and JavaScript if needed
- Reusable elements follow consistent naming: `snipplets/{area}/{component}.tpl`

### Template Variables
Templates use Nuvemshop's template variables and functions:
- `{{ store.url }}`: Store base URL
- `{{ product.name }}`: Product data
- `{{ 'Translation key' | translate }}`: Translations
- `{% include 'snipplets/path.tpl' %}`: Template includes

### Responsive Design
- Mobile-first approach using Bootstrap Grid v4.1.3
- Responsive utilities: `d-md-block`, `col-md-6`, etc.
- Custom breakpoints defined in SCSS variables

## Customization System

### Theme Settings
Settings are defined in `config/settings.txt` and include:
- Color schemes and palettes
- Typography settings
- Layout configurations
- Feature toggles
- Content management options

### Multi-language Support
- Translations in `config/translations.txt`
- Supports Spanish, English, Portuguese, and Mexican Spanish
- Translation function: `{{ 'key' | translate }}`

## Performance Considerations

### CSS Loading Strategy
1. Critical CSS is inlined in the layout for fast initial render
2. Async CSS is loaded after page load for non-essential styles
3. Color CSS is generated dynamically from theme settings

### JavaScript Architecture
- Vanilla JavaScript with theme-specific functionality
- Swiper 4.4.2 for sliders and carousels
- AJAX functionality for cart operations
- Platform-specific JavaScript APIs for e-commerce features

## E-commerce Features

### Product System
- Product variants with color/size options
- Image galleries with zoom functionality
- Related products and recommendations
- Product filtering and search
- Stock management display

### Cart and Checkout
- AJAX cart operations
- Shipping calculator integration
- Multiple payment method display
- Guest and registered checkout flows

### Content Management
- Customizable homepage sections
- Banner and slider management
- Blog functionality
- Newsletter integration
- Social media connectivity

## Platform-Specific Considerations

- Development must follow Nuvemshop's template syntax and conventions
- Theme settings are managed through platform admin interface
- JavaScript and CSS processing is handled by the platform
- File structure and naming conventions are strictly enforced
- Testing requires deployment to Nuvemshop development store

## File Modification Guidelines

When editing templates:
- Maintain consistent indentation and structure
- Use platform template functions and variables
- Follow responsive design patterns established in existing components
- Keep styling modular using the three-tier CSS system
- Test across different screen sizes and devices