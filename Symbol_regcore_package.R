###############################################################################
## regcore R package: Hexagon Sticker -----------------------------------------
## Author: Ricardo Rasmussen Petterle - UFPR ----------------------------------
## Date: August 14, 2026 ------------------------------------------------------
###############################################################################

## Loading extra packages
library(ggplot2)

## Configuration
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))
limit_val <- 1.05

set.seed(101)
n_snow <- 2500
ocean_snow <- data.frame(
  x = runif(n_snow, -1, 1), y = runif(n_snow, -1, 1),
  size = runif(n_snow, 0.05, 0.8), alpha = runif(n_snow, 0.1, 0.55)
)
ocean_snow <- subset(ocean_snow, x^2 + y^2 < 0.85)

x_seq <- seq(0, 1, length.out = 1500)
x_scaled <- x_seq * 1.1 - 0.55 # Scaling X to fit the hexagon

y_center <- 0.45 * x_seq - 0.05 

x_diff <- x_seq - 0.5
y_se <- 0.08 * sqrt(1 + 4 * x_diff^2)
y_lower <- y_center - y_se
y_upper <- y_center + y_se

df_curve <- data.frame(
  x = x_scaled, 
  y = y_center, 
  y_lower = y_lower, 
  y_upper = y_upper, 
  x_orig = x_seq
)

set.seed(42)
n_pts <- 40
x_pts_orig <- runif(n_pts, 0.05, 0.95)
y_pts_orig <- 0.45 * x_pts_orig - 0.05 + rnorm(n_pts, 0, 0.05)
df_pts <- data.frame(
  x = x_pts_orig * 1.1 - 0.55,
  y = y_pts_orig
)

## Figure
p <- ggplot() +
  
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#000814", color = "#48CAE4", linewidth = 4) +
  geom_point(data = ocean_snow, aes(x = x, y = y, size = size, alpha = alpha), color = "#E0FFFF", shape = 16) +
  scale_size_identity() + scale_alpha_identity() +
  
  geom_segment(data = df_curve, aes(x = x, xend = x, y = y_lower, yend = y_upper, color = x_orig), alpha = 0.7) +
  scale_color_gradient(low = "#002B49", high = "#00E5FF", guide = "none") +
  
  geom_segment(aes(x = -0.55, xend = -0.55, y = -0.20, yend = 0.55), color = "#00BFFF", linewidth = 0.8, alpha = 0.6) +
  geom_segment(aes(x = -0.55, xend = 0.55, y = -0.20, yend = -0.20), color = "#00BFFF", linewidth = 0.8, alpha = 0.6) +
  
  geom_point(data = df_pts, aes(x = x, y = y), color = "#00E5FF", size = 1.8, alpha = 0.8) +
  geom_point(data = df_pts, aes(x = x, y = y), color = "#FFFFFF", size = 0.6) +
  
  geom_line(data = df_curve, aes(x = x, y = y), color = "#00E5FF", linewidth = 3, alpha = 0.3) +
  geom_line(data = df_curve, aes(x = x, y = y), color = "#FFFFFF", linewidth = 1) +
  
  annotate("text", x = 0, y = -0.4, label = "regcore", color = "#FFFFFF", size = 12, fontface = "bold", family = "sans") +
  annotate("text", x = 0, y = -0.59, label = "S3 Methods for Regression", color = "#48CAE4", size = 4.4, family = "sans", fontface = "bold") +
  
  coord_fixed(xlim = c(-limit_val, limit_val), ylim = c(-limit_val, limit_val)) + 
  theme_void() + 
  theme(
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent", color = NA),
    legend.position = "none"
  )
p

## Save
ggsave("Logo.png", p, width = 6.35, height = 5.53, bg = "transparent", dpi = 300)
## END ------------------------------------------------------------------------