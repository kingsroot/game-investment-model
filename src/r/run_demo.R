# Data aggregation and linear model (R)
library(tidyverse)
library(lubridate)

# Paths
root <- normalizePath(file.path(dirname(dirname(getwd()))), winslash = "/")
csv <- file.path(root, "data", "sample", "sample_revenue.csv")

# Read
all_data <- read.csv(csv, fileEncoding = "UTF-8")
all_data$Date <- ymd(all_data$Date)
all_data$Month <- floor_date(all_data$Date, "month")

# Summarise monthly
monthly <- all_data %>%
  group_by(Game, Platform, Month) %>%
  summarise(Monthly_Revenue = sum(Revenue, na.rm = TRUE), .groups = "drop")

# Model
model <- lm(Monthly_Revenue ~ Platform + Game, data = monthly)
print(summary(model))

# Plot
library(ggplot2)
p <- ggplot(monthly, aes(x = Month, y = Monthly_Revenue, color = Game)) +
  geom_line() +
  facet_wrap(~Platform) +
  theme_minimal() +
  labs(title = "Monthly Revenue by Game", x = "Month", y = "Revenue")
fig <- file.path(root, "reports", "figures", "r_monthly_revenue.png")
ggsave(fig, p, width = 8, height = 5, dpi = 150)
cat("Saved figure to:", fig, "\n")