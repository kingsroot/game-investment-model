# Sample Data Schema

Place **CSV** files in `data/raw/` with at least these columns:

- `Date` (YYYY-MM-DD)
- `Revenue` (numeric; e.g., CNY)
- `Game` (string)
- `Platform` (string; e.g., iOS/Android/PC)
- `Type` (e.g., MOBA, MMORPG, FPS, SLG, Casual)
- `Genre` (tags; pipe-separated if multiple, e.g., "3D|Multiplayer|Mobile")
- `Audience_Gender` (Male/Female/Mixed)
- `Audience_Age` (e.g., "12-17","18-24","25-34", ...)
- `Monetization` (Gacha/Direct Sale/Sub/Buy-to-Play)
- `Status` (Active/Shutdown)
- `Shutdown_Reason` (if any, optional)

Put cleaned, aggregated monthly data in `data/processed/`.