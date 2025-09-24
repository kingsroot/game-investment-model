
# === 加载必要库 ===
library(tidyverse)
library(lubridate)

# === 设置数据文件夹路径（需根据实际路径修改）===
data_path <- "your_path/tencent_game_data"

# === 获取所有CSV文件名 ===
files <- list.files(path = data_path, pattern = "*.csv", full.names = TRUE)

# === 批量读取并整合所有数据 ===
all_data <- lapply(files, function(file) {
  df <- read.csv(file, fileEncoding = "UTF-8")
  df$Game <- gsub("iphone|ipad|\\.csv|\\(|\\)| ", "", basename(file))  # 提取游戏名
  df$Platform <- ifelse(grepl("ipad", file), "iPad", "iPhone")
  colnames(df) <- c("Date", "Revenue", "Game", "Platform")
  return(df)
}) %>% bind_rows()

# === 数据清洗 ===
all_data$Date <- ymd(all_data$Date)
all_data$Month <- floor_date(all_data$Date, "month")

# === 汇总月收入 ===
monthly_data <- all_data %>%
  group_by(Game, Platform, Month) %>%
  summarise(Monthly_Revenue = sum(Revenue, na.rm = TRUE), .groups = "drop")

# === 建立回归模型（以收入为因变量，平台和游戏为自变量）===
model <- lm(Monthly_Revenue ~ Platform + Game, data = monthly_data)
summary(model)

# === 可视化示例：不同游戏月度收入趋势 ===
ggplot(monthly_data, aes(x = Month, y = Monthly_Revenue, color = Game)) +
  geom_line() +
  facet_wrap(~Platform) +
  theme_minimal() +
  labs(title = "各游戏每月收入趋势", x = "月份", y = "月收入（元）")
