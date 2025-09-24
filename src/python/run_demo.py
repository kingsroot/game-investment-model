"""
Data prep and simple supervised + time-series demo
"""
import pandas as pd
from pathlib import Path
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.metrics import r2_score, mean_absolute_error, accuracy_score
import matplotlib.pyplot as plt

DATA = Path(__file__).resolve().parents[2] / "data" / "sample" / "sample_revenue.csv"
df = pd.read_csv(DATA, parse_dates=["Date"])

# Feature engineering
df["Month"] = df["Date"].dt.to_period("M").dt.to_timestamp()
# Example binary target: "investable" if revenue >= median of each game
df["Investable"] = df.groupby("Game")["Revenue"].transform(lambda s: (s >= s.median()).astype(int))

X = df[["Game","Platform","Type","Genre","Audience_Gender","Monetization"]]
y_reg = df["Revenue"]
y_clf = df["Investable"]

cat_cols = X.columns.tolist()
pre = ColumnTransformer([("cat", OneHotEncoder(handle_unknown="ignore"), cat_cols)])

# Regression
reg = Pipeline([("pre", pre), ("lr", LinearRegression())])
reg.fit(X, y_reg)
pred = reg.predict(X)
print("REG R2:", r2_score(y_reg, pred))
print("REG MAE:", mean_absolute_error(y_reg, pred))

# Classification
clf = Pipeline([("pre", pre), ("lr", LogisticRegression(max_iter=1000))])
clf.fit(X, y_clf)
proba = clf.predict_proba(X)[:,1]
pred_cls = (proba >= 0.5).astype(int)
print("CLF ACC:", accuracy_score(y_clf, pred_cls))

# Simple time series plot
fig = plt.figure()
for g, gdf in df.groupby("Game"):
    gdf = gdf.sort_values("Date")
    plt.plot(gdf["Date"], gdf["Revenue"], label=g)
plt.title("Monthly Revenue (sample)")
plt.xlabel("Date")
plt.ylabel("Revenue")
plt.legend()
fig_path = Path(__file__).resolve().parents[2] / "reports" / "figures" / "sample_timeseries.png"
plt.savefig(fig_path, bbox_inches="tight")
print(f"Saved figure to: {fig_path}")