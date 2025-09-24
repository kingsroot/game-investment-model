# Game Investment Modeling (Tencent Case Study)

> Predict which game **types** are more investment-worthy, forecast future performance, and spot **emerging dark horses** using CS + math + statistical modeling.

## 🎯 Goals
- Identify high-ROI **game types** among large publishers (initial focus: **Tencent**).
- Forecast revenues and detect trend **inflection points** (e.g., seasonal peaks, policy, pandemic effects).
- Classify titles as **"investable"** and highlight potential **dark horses**.

## 📦 Repo Structure
```
.
├── data/
│   ├── raw/          # put raw CSV exports here
│   ├── processed/    # cleaned & aggregated data
│   └── sample/       # sample dataset & schema
├── notebooks/        # exploratory analysis
├── reports/
│   └── figures/      # saved plots
├── src/
│   ├── python/       # ML pipelines (sklearn/statsmodels/prophet)
│   └── r/            # data aggregation & visualization
└── tests/            # unit tests (future)
```

## 🧠 Methods (Supervised + Time Series)
- **Regression** (Linear / MLR): quantify effects of Type/Genre/Audience on revenue.
- **Classification** (Logistic): probability a title is "investable".
- **Tree Ensembles** (RF/XGBoost): non-linearities & feature importance.
- **Time Series** (ARIMA/Prophet/LSTM): forecast by title / portfolio.
- **Clustering** (KMeans/DBSCAN): discover segments & potential "dark horses".

## 📊 Data fields (minimum)
See `data/sample/SCHEMA.md`. Example columns: `Date, Revenue, Game, Platform, Type, Genre, Audience_*, Monetization, Status, Shutdown_Reason`.

## 🚀 Quickstart
### Option A: Python (pip)
```bash
python -m venv .venv && source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
python src/python/run_demo.py
```

### Option B: Conda
```bash
conda env create -f environment.yml
conda activate game-investment-model
python src/python/run_demo.py
```

### Option C: R
Open `src/r/run_demo.R` and run. Output figures are saved in `reports/figures/`.

## 🗂 Data Ingestion
1. Export title-level revenue by **month** (or day) to `data/raw/` (CSV).
2. Use R/Python scripts to clean and aggregate to `data/processed/`.
3. Update models to include features: **Type, Genre tags (3D/Multiplayer/Mobile), Audience, Monetization, Status**.

## 📈 Outputs
- Feature effects (e.g., MOBA / Multiplayer / 3D) on revenue.
- Title-level forecasts and confidence intervals.
- **Investable** classification scores and a ranked watchlist.
- Visualizations: trend lines, seasonal peaks, post-event shifts.

## 🤖 Roadmap
- Add **Prophet** and **ARIMA** forecasters per title.
- Add **XGBoost** classifier + SHAP explanations.
- Portfolio simulation (optimal investment allocation).
- CI enhancements & **unit tests** for pipelines.

## 📄 License
MIT