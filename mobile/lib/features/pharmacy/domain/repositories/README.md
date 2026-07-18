# Repository Interfaces

Abstract contracts (e.g. `PharmacyRepository`) that the presentation layer
depends on. Implemented by `data/repositories`; kept separate so domain and
presentation code never import `dio` or any data-layer type directly.

No implementation yet — this is architecture scaffolding only.
