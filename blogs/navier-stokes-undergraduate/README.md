# Navier-Stokes blog package

- `article.md`: the complete copyable Markdown blog, with inline source links and image captions.
- `assets/`: three original illustrations in PNG and SVG formats.
- `make_figures.py`: reproducible figure source, requiring Python, NumPy, and Matplotlib.

## Publishing the images

The Markdown uses relative image paths such as `assets/mantle-wedge.png`. They work when the article and assets are kept together in a compatible Markdown viewer or publishing system.

For a blog editor that stores only Markdown text, upload the three PNGs to your site's image hosting, then replace each relative image path with its public image URL. Copying the Markdown text alone does not upload the images. SVG versions are included for resizing or editing.

Published at https://matematisko.vercel.app/blogs/from-mantle-flow-to-navier-stokes. The live database post is approved and published. `article.website.md` contains the published body with public Supabase image URLs and omits the title already rendered by the page header. Anonymous API reads matched the prepared content, and all three public image downloads matched the local PNG hashes. No frontend redeployment was required.

## Editorial and validation notes

The article's news cutoff is September 16, 2026. The manuscript's smooth-forced blowup claim, Clay's September 11 response, Clay's prize rules, the EMS statement, and the parties' public accounts are linked where discussed. Claims about the dispute remain attributed. Refresh the status before a later publication date.

The author's personal background is limited to the supplied facts: undergraduate mathematics, no PDE class in the coursework described, and a thesis involving Stokes equations for mantle-wedge flow. No numerical thesis results or specific thesis methods have been invented.

The illustrations are educational examples, not thesis results or simulations of the new construction. The Gaussian curves have squared integral exactly one analytically; their plotted approximations were also checked numerically. All blog math was checked using KaTeX and the complete article rendered in the app's MathRenderer. All three image references resolve locally. Figures were visually inspected. No independent audit or compilation of the research announcement's Lean proof was performed.
