
## Loading extra package
library(ggplot2)

## ------------------------------------------------------------------
## 1. A Matemática do Hexágono
## ------------------------------------------------------------------
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(
  x = cos(angles),
  y = sin(angles)
)

## ------------------------------------------------------------------
## 2. A Assinatura do Desacoplamento (As 3 Curvas)
## ------------------------------------------------------------------
x_beta <- seq(0.001, 0.999, length.out = 500)
mu  <- 0.3
phi <- 8

# 2.1 Calculando os parâmetros de forma teóricos
a_std <- mu * phi + 1;                b_std <- (1 - mu) * phi + 1
a_left <- 1 + phi;                    b_left <- 1 + phi * ((1 - mu) / mu)
a_right <- 1 + phi * (mu / (1 - mu)); b_right <- 1 + phi

# 2.2 Gerando as densidades reais
y_std   <- dbeta(x_beta, a_std, b_std)
y_left  <- dbeta(x_beta, a_left, b_left)
y_right <- dbeta(x_beta, a_right, b_right)

# 2.3 Normalizando para que todas dividam o mesmo pico visual exato no logo
y_std_norm   <- y_std / max(y_std)
y_left_norm  <- y_left / max(y_left)
y_right_norm <- y_right / max(y_right)

# 2.4 Mapeando as coordenadas para dentro do Hexágono
# Eixo X centralizado e escalado
x_hex <- x_beta * 1.4 - 0.7
mu_hex <- mu * 1.4 - 0.7

# Eixo Y posicionado acima do nome "betamodal"
y_base <- -0.15
y_peak <- 0.55
y_range <- y_peak - y_base

df_curves <- data.frame(
  x = rep(x_hex, 3),
  y = c(y_std_norm * y_range + y_base,
        y_left_norm * y_range + y_base,
        y_right_norm * y_range + y_base),
  model = factor(rep(c("Standard", "Left", "Right"), each = 500),
                 levels = c("Standard", "Left", "Right"))
)

## ------------------------------------------------------------------
## 3. Desenhando a Identidade Visual
## ------------------------------------------------------------------
p <- ggplot() +
  
  # Fundo e Borda
  geom_polygon(data = hex_df, aes(x = x, y = y),
               fill = "#1A1A1A", color = "#005031", linewidth = 4) +
  
  # Linha guia da Moda (ancorando o pico à base)
  geom_segment(aes(x = mu_hex, xend = mu_hex, y = y_base, yend = y_peak), 
               color = "gray40", linetype = "dotted", linewidth = 0.8) +
  
  # As 3 Curvas de Densidade Desacopladas
  geom_line(data = df_curves, aes(x = x, y = y, color = model), linewidth = 1.2) +
  
  geom_point(aes(x = mu_hex, y = y_peak), color = "white", size = 3) +
  
  annotate("text", x = 0, y = -0.42, label = "betamodal",
           color = "white", size = 16, fontface = "bold", family = "serif") +
  
  scale_color_manual(values = c("Standard" = "#FFFFFF", 
                                "Left" = "#81C784", 
                                "Right" = "#B0BEC5")) +
  
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = NA),
        legend.position = "none") 
p
## ------------------------------------------------------------------
## 4. Exportando
## ------------------------------------------------------------------
# ggsave("betamodal_hex_signature.png", p, width = 5, height = 5, bg = "transparent", dpi = 300)

library(ggplot2)

## ------------------------------------------------------------------
## 1. A Matemática do Hexágono
## ------------------------------------------------------------------
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(
  x = cos(angles),
  y = sin(angles)
)

## ------------------------------------------------------------------
## 2. A Curva Focada na Moda (Cinza Claro)
## ------------------------------------------------------------------
x_beta <- seq(0.001, 0.999, length.out = 500)

# Criando uma curva bem assimétrica para enfatizar o desvio da média
mu <- 0.25 
phi <- 12

# Calculando a densidade
a_std <- mu * phi + 1
b_std <- (1 - mu) * phi + 1
y_beta <- dbeta(x_beta, a_std, b_std)

# Mapeando as coordenadas para dentro do Hexágono
x_hex <- x_beta * 1.4 - 0.7
mu_hex <- mu * 1.4 - 0.7

y_base <- -0.15
y_peak <- 0.55
y_range <- y_peak - y_base

# Normalizando e escalonando
y_scaled <- (y_beta / max(y_beta)) * y_range + y_base

df_curve <- data.frame(x = x_hex, y = y_scaled)

## ------------------------------------------------------------------
## 3. Desenhando a Identidade Visual
## ------------------------------------------------------------------
p <- ggplot() +
  
  # Fundo e Borda Verde Araucária
  geom_polygon(data = hex_df, aes(x = x, y = y),
               fill = "gray15", color = "#005031", linewidth = 4) +
  
  # Sombra suave sob a curva (opcional, dá volume e elegância)
  # geom_area(data = df_curve, aes(x = x, y = y), 
    #        fill = "gray80", alpha = 0.1) +
  
  # Linha guia da Moda pontilhada (descendo do pico)
  geom_segment(aes(x = mu_hex, xend = mu_hex, y = y_base, yend = y_peak), 
               color = "gray60", linetype = "dotted", linewidth = 0.8) +
  
  # A Curva Beta em Cinza Claro (gray80)
  geom_line(data = df_curve, aes(x = x, y = y), 
            color = "gray80", linewidth = 1.8) +
  
  # O Ponto de Máximo (A Locação Modal) em Dourado Suave
  geom_point(aes(x = mu_hex, y = y_peak), 
             color = "#D4AF37", size = 3.5) +
  
  # A base da curva (eixo X imaginário)
  geom_segment(aes(x = -0.7, xend = 0.7, y = y_base, yend = y_base), 
               color = "gray40", linewidth = 0.5) +
  
  # O Nome do Pacote
  annotate("text", x = 0, y = -0.4, label = "betamodal",
           color = "white", size = 13.5, fontface = "bold", family = "serif") +
  
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = NA))
p
## ------------------------------------------------------------------
## 4. Exportando
## ------------------------------------------------------------------
# ggsave("betamodal_hex_focus.png", p, width = 5, height = 5, bg = "transparent", dpi = 300)
# ggsave("betamodal_hex_focus2.png", p, width = 5, height = 5, dpi = 300)

library(ggplot2)

## ------------------------------------------------------------------
## 1. A Matemática do Hexágono (Borda Dupla)
## ------------------------------------------------------------------
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6

# Hexágono Base (Fundo e Borda Externa)
hex_base <- data.frame(
  x = cos(angles),
  y = sin(angles)
)

# Hexágono Interno (Linha Ciano)
hex_inner <- data.frame(
  x = cos(angles) * 0.92,
  y = sin(angles) * 0.92
)

## ------------------------------------------------------------------
## 2. A Matemática das Camadas (Curvas de Trás para Frente)
## ------------------------------------------------------------------
x_seq <- seq(-0.75, 0.75, length.out = 500)
y_base <- -0.15 # O "chão" exato das distribuições

# Função auxiliar para criar as curvas fechadas (polígonos)
create_layer <- function(sd, height) {
  # Usando formato normal escalonado
  y_curve <- exp(-(x_seq^2) / (2 * sd^2)) * height + y_base
  data.frame(
    x = c(x_seq, 0.75, -0.75),
    y = c(y_curve, y_base, y_base)
  )
}

# Criando as 4 camadas (Da mais alta/fundo para a mais baixa/frente)
# Os parâmetros de 'sd' (largura) e 'height' (altura) imitam a imagem original
layer1_purple_light <- create_layer(sd = 0.20, height = 0.85)
layer2_purple_dark  <- create_layer(sd = 0.23, height = 0.65)
layer3_blue_medium  <- create_layer(sd = 0.28, height = 0.45)
layer4_blue_dark    <- create_layer(sd = 0.35, height = 0.30)

## ------------------------------------------------------------------
## 3. Desenhando a Identidade Visual
## ------------------------------------------------------------------
p <- ggplot() +
  
  # Fundo do Hexágono e Borda Externa Escura
  geom_polygon(data = hex_base, aes(x = x, y = y),
               fill = "#0E3E4B", color = "#16646B", linewidth = 6) +
  
  # Borda Interna Ciano (Estilo Neon)
  geom_polygon(data = hex_inner, aes(x = x, y = y),
               fill = NA, color = "#35D0D6", linewidth = 2.5) +
  
  # Camada 1 (Fundo): Lilás Claro
  geom_polygon(data = layer1_purple_light, aes(x = x, y = y), 
               fill = "#A26BB5") +
  
  # Camada 2: Roxo Médio
  geom_polygon(data = layer2_purple_dark, aes(x = x, y = y), 
               fill = "#6F53A4") +
  
  # Camada 3: Azul Médio
  geom_polygon(data = layer3_blue_medium, aes(x = x, y = y), 
               fill = "#214DA8") +
  
  # Camada 4 (Frente): Azul Escuro
  geom_polygon(data = layer4_blue_dark, aes(x = x, y = y), 
               fill = "#00378E") +
  
  # Sombra do Texto (Para dar o efeito "Pop/3D" da foto)
  annotate("text", x = 0.015, y = -0.485, label = "betamodal",
           color = "#001D2B", size = 15, fontface = "bold", family = "sans", alpha = 0.6) +
  
  # Texto Principal Branco
  annotate("text", x = 0, y = -0.47, label = "betamodal",
           color = "white", size = 15, fontface = "bold", family = "sans") +
  
  # Ajuste de Proporção e Limpeza do Eixo
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = NA))
p
## ------------------------------------------------------------------
## 4. Exportação
## ------------------------------------------------------------------
# ggsave("betamodal_hex_layered.png", p, width = 5, height = 5, bg = "transparent", dpi = 300)

library(ggplot2)

## ------------------------------------------------------------------
## 1. A Matemática do Hexágono (Borda Preta)
## ------------------------------------------------------------------
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(
  x = cos(angles),
  y = sin(angles)
)

## ------------------------------------------------------------------
## 2. A Curva de Densidade e os Eixos
## ------------------------------------------------------------------
# Simulando a curva assimétrica (ex: Beta)
# Usamos 1500 pontos para garantir que o gradiente fique contínuo e sem falhas
x_seq <- seq(0.001, 0.999, length.out = 1500)
y_seq <- dbeta(x_seq, shape1 = 2.5, shape2 = 6) 

# Escalonando os dados para caberem exatamente na metade superior do hexágono
# O plot vai de x = -0.55 até 0.55, e y = -0.05 até 0.55
x_scaled <- x_seq * 1.1 - 0.55
y_scaled <- (y_seq / max(y_seq)) * 0.6 - 0.05

df_curve <- data.frame(
  x = x_scaled,
  y = y_scaled,
  x_orig = x_seq # Guardamos o valor original [0,1] para mapear a cor do gradiente
)

# Posições das marcações (ticks) dos eixos
x_ticks <- seq(-0.55, 0.55, length.out = 6)
y_ticks <- seq(-0.05, 0.55, length.out = 6)

## ------------------------------------------------------------------
## 3. Desenhando a Identidade Visual
## ------------------------------------------------------------------
p <- ggplot() +
  
  # Fundo Branco e Borda Preta Espessa
  geom_polygon(data = hex_df, aes(x = x, y = y),
               fill = "white", color = "black", linewidth = 5) +
  
  # O Truque do Gradiente: Linhas verticais preenchendo a área
  geom_segment(data = df_curve, aes(x = x, xend = x, y = -0.05, yend = y, color = x_orig)) +
  # Cores extraídas da sua imagem (do roxo/azulado para o verde água)
  scale_color_gradient(low = "#747E9E", high = "#9CD2C2", guide = "none") +
  
  # Contorno da Curva
  geom_line(data = df_curve, aes(x = x, y = y), color = "#5A6A8C", linewidth = 1.2) +
  
  # --- EIXO Y ---
  # Linha do eixo
  geom_segment(aes(x = -0.55, xend = -0.55, y = -0.05, yend = 0.55), color = "black", linewidth = 0.8) +
  # Marcações (ticks) do eixo Y apontando para a esquerda
  geom_segment(aes(x = -0.55, xend = -0.58, y = y_ticks, yend = y_ticks), color = "black", linewidth = 0.8) +
  
  # --- EIXO X ---
  # Linha do eixo
  geom_segment(aes(x = -0.55, xend = 0.55, y = -0.05, yend = -0.05), color = "black", linewidth = 0.8) +
  # Marcações (ticks) do eixo X apontando para baixo
  geom_segment(aes(x = x_ticks, xend = x_ticks, y = -0.05, yend = -0.08), color = "black", linewidth = 0.8) +
  
  # Textos dos Eixos (0 e 1)
  annotate("text", x = -0.55, y = -0.13, label = "0", size = 5.5, fontface = "bold", family = "sans") +
  annotate("text", x = 0.55, y = -0.13, label = "1", size = 5.5, fontface = "bold", family = "sans") +
  
  # --- TIPOGRAFIA PRINCIPAL ---
  # O nome "unitreg" (Azul Marinho) alinhado à direita do ponto central
  annotate("text", x = 0.015, y = -0.32, label = "unitreg", 
           color = "#0B0B3B", size = 17, fontface = "bold", family = "sans", hjust = 1) +
  
  # O nome "TMB" (Azul Ciano) alinhado à esquerda do ponto central
  annotate("text", x = 0.015, y = -0.32, label = "TMB", 
           color = "#118AB2", size = 17, fontface = "bold", family = "sans", hjust = 0) +
  
  # O Subtítulo (Cinza)
  annotate("text", x = 0, y = -0.52, label = "Unit Interval Regression", 
           color = "#4D4D4D", size = 6, family = "sans") +
  
  # Configurações do Layout
  coord_fixed() +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = NA))
p
## ------------------------------------------------------------------
## 4. Exportação
## ------------------------------------------------------------------
# ggsave("unitregTMB_logo_oficial.png", p, width = 5, height = 5, bg = "transparent", dpi = 300)

library(ggplot2)

# Hexágono Base
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Construindo a "Matriz Esparsa" (Grade de Pontos)
set.seed(42)
grid_x <- seq(-0.7, 0.7, by = 0.12)
grid_y <- seq(-0.5, 0.7, by = 0.12)
sparse_grid <- expand.grid(x = grid_x, y = grid_y)
# Removendo pontos aleatórios para dar o efeito "esparso"
sparse_grid <- sparse_grid[sample(1:nrow(sparse_grid), nrow(sparse_grid) * 0.4), ]

# Construindo conexões aleatórias (esparsas)
edges <- data.frame(
  x = sparse_grid$x[-nrow(sparse_grid)],
  y = sparse_grid$y[-nrow(sparse_grid)],
  xend = sparse_grid$x[-1],
  yend = sparse_grid$y[-1]
)

# A Curva de Regressão Não-Linear
x_curve <- seq(-0.75, 0.75, length.out = 200)
y_curve <- 0.25 * sin(5 * x_curve) + 0.15
df_curve <- data.frame(x = x_curve, y = y_curve)

p1 <- ggplot() +
  # Fundo roxo profundo e borda prateada
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#170B21", color = "#9E9E9E", linewidth = 4) +
  # Linhas da Matriz
  geom_segment(data = edges, aes(x = x, y = y, xend = xend, yend = yend), color = "gray40", alpha = 0.3, linewidth = 0.5) +
  
  # Nós (Pontos) da Matriz
  geom_point(data = sparse_grid, aes(x = x, y = y), color = "#B0BEC5", size = 1.5, alpha = 0.6) +
  
  # A Curva Não-Linear (Verde Neon) com brilho
  geom_line(data = df_curve, aes(x = x, y = y), color = "#39FF14", linewidth = 3, alpha = 0.3) +
  geom_line(data = df_curve, aes(x = x, y = y), color = "#39FF14", linewidth = 1.5) +
  
  # Nome
  annotate("text", x = 0, y = -0.5, label = "regcore", color = "white", size = 15, fontface = "bold", family = "serif") +
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))
p1
# ggsave("unitregTMB_matriz.png", p1, width = 5, height = 5, bg = "transparent", dpi = 300)


library(ggplot2)

# Hexágono Base
angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# A Curva de Regressão Não-Linear (O "Core")
x_curve <- seq(-0.75, 0.75, length.out = 200)
y_curve <- 0.25 * sin(5 * x_curve) + 0.15
df_curve <- data.frame(x = x_curve, y = y_curve)

# Simulando "Dados" em torno do Core
set.seed(42)
x_data <- runif(45, -0.7, 0.7)
# Adicionando ruído à curva para criar os pontos de dispersão
y_data <- 0.25 * sin(5 * x_data) + 0.15 + rnorm(45, mean = 0, sd = 0.12)
df_data <- data.frame(x = x_data, y = y_data)

# Calculando os valores preditos para criar as linhas de resíduo
df_data$y_hat <- 0.25 * sin(5 * df_data$x) + 0.15

p1 <- ggplot() +
  # Fundo roxo profundo e borda prateada
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#170B21", color = "#9E9E9E", linewidth = 4) +
  
  # Linhas de Resíduo (Conectando os dados à curva - a essência da regressão)
  geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "gray50", alpha = 0.5, linetype = "dotted") +
  
  # Nós (Pontos de Dados)
  geom_point(data = df_data, aes(x = x, y = y), color = "#B0BEC5", size = 1.8, alpha = 0.8) +
  
  # A Curva Não-Linear (Verde Neon) com brilho
  geom_line(data = df_curve, aes(x = x, y = y), color = "#39FF14", linewidth = 3, alpha = 0.3) +
  geom_line(data = df_curve, aes(x = x, y = y), color = "#39FF14", linewidth = 1.2) +
  
  # Nome
  annotate("text", x = 0, y = -0.45, label = "regcore", color = "white", size = 14, fontface = "bold", family = "sans") +
  
  coord_fixed() + 
  theme_void() + 
  theme(plot.background = element_rect(fill = "transparent", color = NA))

p1


library(ggplot2)

angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

x_curve <- seq(-0.75, 0.75, length.out = 200)
y_curve <- 0.25 * sin(5 * x_curve) + 0.15
df_curve <- data.frame(x = x_curve, y = y_curve)

set.seed(42)
x_data <- runif(45, -0.7, 0.7)
y_data <- 0.25 * sin(5 * x_data) + 0.15 + rnorm(45, 0, 0.12)
df_data <- data.frame(x = x_data, y = y_data)
df_data$y_hat <- 0.25 * sin(5 * df_data$x) + 0.15

ggplot() +
  # Fundo branco/cinza muito claro com borda chumbo grossa
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#F8F9FA", color = "#212529", linewidth = 4) +
  
  # Resíduos e dados em cinza médio
  geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "#ADB5BD", alpha = 0.7, linetype = "dashed") +
  geom_point(data = df_data, aes(x = x, y = y), color = "#495057", size = 2, alpha = 0.8) +
  
  # Curva central preta e forte
  geom_line(data = df_curve, aes(x = x, y = y), color = "#000000", linewidth = 1.8) +
  
  # Nome em tom escuro, fonte serifada clássica
  annotate("text", x = 0, y = -0.45, label = "regcore", color = "#212529", size = 14, fontface = "bold", family = "serif") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

x_curve <- seq(-0.75, 0.75, length.out = 200)
y_curve <- 0.25 * sin(5 * x_curve) + 0.15
df_curve <- data.frame(x = x_curve, y = y_curve)

set.seed(42)
x_data <- runif(45, -0.7, 0.7)
y_data <- 0.25 * sin(5 * x_data) + 0.15 + rnorm(45, 0, 0.12)
df_data <- data.frame(x = x_data, y = y_data)
df_data$y_hat <- 0.25 * sin(5 * df_data$x) + 0.15

ggplot() +
  # Fundo Azul Marinho profundo e borda azul claro/cinza
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#0A192F", color = "#607D8B", linewidth = 4) +
  
  # Resíduos e dados em azul claro (cyan)
  geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "#4CC9F0", alpha = 0.4, linetype = "dotted") +
  geom_point(data = df_data, aes(x = x, y = y), color = "#4CC9F0", size = 1.8, alpha = 0.9) +
  
  # Curva em Laranja/Âmbar brilhante
  geom_line(data = df_curve, aes(x = x, y = y), color = "#FF9F1C", linewidth = 3, alpha = 0.3) +
  geom_line(data = df_curve, aes(x = x, y = y), color = "#FF9F1C", linewidth = 1.2) +
  
  annotate("text", x = 0, y = -0.45, label = "regcore", color = "white", size = 14, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- seq(0, 2 * pi, length.out = 7) + pi / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

x_curve <- seq(-0.75, 0.75, length.out = 200)
# Efeito Fixo (Curva Central)
df_fixed <- data.frame(x = x_curve, y = 0.25 * sin(5 * x_curve) + 0.15)

# Efeitos Aleatórios (Curvas secundárias)
df_ran1 <- data.frame(x = x_curve, y = 0.25 * sin(5 * x_curve) + 0.35)
df_ran2 <- data.frame(x = x_curve, y = 0.25 * sin(5 * x_curve) - 0.05)
df_ran3 <- data.frame(x = x_curve, y = 0.20 * sin(5 * x_curve) + 0.20)

ggplot() +
  # Fundo Escuro com borda Cobre/Dourada
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#1E1E24", color = "#C5A880", linewidth = 4) +
  
  # Curvas de Efeitos Aleatórios (mais finas e transparentes)
  geom_line(data = df_ran1, aes(x = x, y = y), color = "#A3C4F3", linewidth = 0.8, alpha = 0.6) +
  geom_line(data = df_ran2, aes(x = x, y = y), color = "#A3C4F3", linewidth = 0.8, alpha = 0.6) +
  geom_line(data = df_ran3, aes(x = x, y = y), color = "#A3C4F3", linewidth = 0.8, alpha = 0.6) +
  
  # Efeito Fixo (Curva Central principal)
  geom_line(data = df_fixed, aes(x = x, y = y), color = "#4361EE", linewidth = 2.5, alpha = 0.4) +
  geom_line(data = df_fixed, aes(x = x, y = y), color = "#4361EE", linewidth = 1.2) +
  
  annotate("text", x = 0, y = -0.45, label = "regcore", color = "white", size = 14, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

# 1. Vértices do Hexágono (Ponta para cima, padrão CRAN)
angles <- (seq(1, 11, by = 2) * pi) / 6
vx <- cos(angles)
vy <- sin(angles)

# 2. Construindo as 3 faces visíveis de um cubo 3D isométrico a partir do hexágono
face_top <- data.frame(
  x = c(0, vx[3], vx[2], vx[1]),
  y = c(0, vy[3], vy[2], vy[1])
)
face_left <- data.frame(
  x = c(0, vx[3], vx[4], vx[5]),
  y = c(0, vy[3], vy[4], vy[5])
)
face_right <- data.frame(
  x = c(0, vx[5], vx[6], vx[1]),
  y = c(0, vy[5], vy[6], vy[1])
)
hex_df <- data.frame(x = vx, y = vy)

# 3. Curva de Regressão (Fluindo através do 'core')
x_curve <- seq(-0.85, 0.85, length.out = 200)
y_curve <- 0.4 * sin(3.5 * x_curve) + 0.15
df_curve <- data.frame(x = x_curve, y = y_curve)

# 4. Dados Simulados
set.seed(99)
x_data <- runif(45, -0.8, 0.8)
y_data <- 0.4 * sin(3.5 * x_data) + 0.15 + rnorm(45, 0, 0.08)
df_data <- data.frame(x = x_data, y = y_data)
df_data$y_hat <- 0.4 * sin(3.5 * df_data$x) + 0.15

# 5. O Plot
ggplot() +
  # Fundo do Cubo (As três dimensões)
  geom_polygon(data = face_top, aes(x = x, y = y), fill = "#282A36", color = "#1E1F29", linewidth = 0.5) +
  geom_polygon(data = face_left, aes(x = x, y = y), fill = "#44475A", color = "#1E1F29", linewidth = 0.5) +
  geom_polygon(data = face_right, aes(x = x, y = y), fill = "#343746", color = "#1E1F29", linewidth = 0.5) +
  
  # Borda Externa
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = NA, color = "#FF79C6", linewidth = 4) +
  
  # Resíduos (Ciano)
  # geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "#8BE9FD", alpha = 0.4, linetype = "solid") +
  
  # Pontos de Dados
  # geom_point(data = df_data, aes(x = x, y = y), color = "#8BE9FD", size = 2.5, alpha = 0.7) +
  # geom_point(data = df_data, aes(x = x, y = y), color = "white", size = 0.8, alpha = 0.9) +
  
  # A Curva (Rosa Neon)
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#FF79C6", linewidth = 3, alpha = 0.3) +
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#FF79C6", linewidth = 1.2) +
  
  # Texto
  annotate("text", x = 0, y = -0.65, label = "regcore", color = "white", size = 14, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))



library(ggplot2)

# Vértices (Ponta para cima)
angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Construindo o "Envelope" (Banda de confiança)
x_env <- seq(-0.85, 0.85, length.out = 100)
y_center <- 0.3 * sin(2.5 * x_env) + 0.1
# Aumentando a banda nas bordas
y_upper <- y_center + 0.25 - 0.08 * x_env^2 
y_lower <- y_center - 0.25 + 0.08 * x_env^2

df_env <- data.frame(
  x = c(x_env, rev(x_env)),
  y = c(y_upper, rev(y_lower))
)
df_center <- data.frame(x = x_env, y = y_center)

# Pontos (Resíduos dentro e fora do envelope)
set.seed(42)
x_res <- runif(70, -0.75, 0.75)
y_res <- 0.3 * sin(2.5 * x_res) + 0.1 + rnorm(70, 0, 0.1)
df_res <- data.frame(x = x_res, y = y_res)

# Plot
ggplot() +
  # Fundo branco e borda chumbo/azul escuro
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#F8F9FA", color = "#2C3E50", linewidth = 4) +
  
  # A sombra do Envelope
  geom_polygon(data = df_env, aes(x = x, y = y), fill = "#BDC3C7", alpha = 0.5) +
  
  # Linha central pontilhada (Referência nula)
  geom_line(data = df_center, aes(x = x, y = y), color = "#7F8C8D", linewidth = 1, linetype = "dashed") +
  
  # Os Resíduos
  geom_point(data = df_res, aes(x = x, y = y), color = "#E74C3C", size = 2, alpha = 0.8) +
  
  # A Curva do Modelo Ajustado
  geom_line(data = df_center, aes(x = x, y = y), color = "#2980B9", linewidth = 2.5) +
  
  # Nome
  annotate("text", x = 0, y = -0.55, label = "regcore", color = "#2C3E50", size = 15, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Simulando dados de estimativas e intervalos de confiança
df_coef <- data.frame(
  id = 1:5,
  y = c(0.45, 0.2, -0.05, -0.3, -0.55),
  est = c(0.4, 0.15, -0.2, 0.5, -0.4),
  xmin = c(0.2, -0.1, -0.5, 0.3, -0.65),
  xmax = c(0.6, 0.4, 0.1, 0.7, -0.15)
)

ggplot() +
  # Fundo Cinza Claro, Estilo "Publication Ready"
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#F8F9FA", color = "#343A40", linewidth = 4) +
  
  # Linha de Referência (Nula)
  geom_segment(aes(x = 0, y = -0.7, xend = 0, yend = 0.7), color = "#ADB5BD", linetype = "dashed", linewidth = 1) +
  
  # Intervalos de Confiança
  geom_segment(data = df_coef, aes(x = xmin, xend = xmax, y = y, yend = y), color = "#495057", linewidth = 1.2) +
  
  # Estimativas Pontuais (com destaque em Azul Acadêmico)
  geom_point(data = df_coef, aes(x = est, y = y), color = "#0D6EFD", size = 4) +
  geom_point(data = df_coef, aes(x = est, y = y), color = "white", size = 1.5) +
  
  # Nome do pacote (ajustado para caber na parte inferior)
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "#343A40", size = 12, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Reta de referência e envelope
x_env <- seq(-0.6, 0.6, length.out = 100)
y_env <- x_env
df_env <- data.frame(
  x = c(x_env, rev(x_env)),
  y = c(y_env + 0.15, rev(y_env - 0.15)) # Banda de confiança constante/linear
)
df_line <- data.frame(x = x_env, y = y_env)

# Resíduos simulados acompanhando a reta
set.seed(123)
x_res <- runif(40, -0.55, 0.55)
y_res <- x_res + rnorm(40, 0, 0.06)
df_res <- data.frame(x = x_res, y = y_res)

ggplot() +
  # Fundo Escuro Metálico com borda Laranja/Dourada
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#212529", color = "#FCA311", linewidth = 4) +
  
  # Sombra do Envelope
  geom_polygon(data = df_env, aes(x = x, y = y), fill = "#495057", alpha = 0.6) +
  
  # Reta principal do modelo
  geom_line(data = df_line, aes(x = x, y = y), color = "#FCA311", linewidth = 2) +
  
  # Pontos de Resíduos
  geom_point(data = df_res, aes(x = x, y = y), color = "#E5E5E5", size = 2.5, alpha = 0.9) +
  
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "white", size = 12, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Grade (Grid) representando a matriz de dados X
grid_lines_v <- data.frame(x = seq(-0.6, 0.6, by = 0.2), xend = seq(-0.6, 0.6, by = 0.2), y = -0.6, yend = 0.6)
grid_lines_h <- data.frame(x = -0.6, xend = 0.6, y = seq(-0.6, 0.6, by = 0.2), yend = seq(-0.6, 0.6, by = 0.2))

# Reta de Regressão Linear Clássica
df_line <- data.frame(x = c(-0.6, 0.6), y = c(-0.4, 0.6))

# Alguns pontos e distâncias (resíduos da regressão linear simples)
set.seed(7)
x_pts <- c(-0.4, -0.2, 0.2, 0.4)
y_pts <- c(0.1, -0.3, 0.4, 0.1)
y_hat <- (-0.4) + ((0.6 - (-0.4)) / (0.6 - (-0.6))) * (x_pts - (-0.6)) # Equação da reta
df_pts <- data.frame(x = x_pts, y = y_pts, y_hat = y_hat)

ggplot() +
  # Fundo Azul Clássico do R / RStudio
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#153E5C", color = "#8FA8B8", linewidth = 4) +
  
  # A Matriz / Grade
  geom_segment(data = grid_lines_v, aes(x = x, y = y, xend = xend, yend = yend), color = "#2B5C7D", linewidth = 0.5) +
  geom_segment(data = grid_lines_h, aes(x = x, y = y, xend = xend, yend = yend), color = "#2B5C7D", linewidth = 0.5) +
  
  # Resíduos verticais
  geom_segment(data = df_pts, aes(x = x, y = y, xend = x, yend = y_hat), color = "#F1C40F", linewidth = 1, linetype = "dotted") +
  
  # Linha de Ajuste Linear Reta
  geom_line(data = df_line, aes(x = x, y = y), color = "#FFFFFF", linewidth = 2) +
  
  # Pontos
  geom_point(data = df_pts, aes(x = x, y = y), color = "#F1C40F", size = 3) +
  
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "white", size = 12, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

# 1. Base do Hexágono (Borda do Sticker)
angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# 2. Motor de Projeção Isométrica 3D para o ggplot2
# Converte coordenadas (x, y, z) do espaço 3D para (x, y) 2D
iso <- function(x, y, z) {
  S <- 0.45 # Escala da caixa dentro do hexágono
  px <- (x - y) * 0.866 * S
  py <- -(x + y) * 0.5 * S + z * S + 0.1
  data.frame(x = px, y = py)
}

# 3. Construindo as faces da "Caixa de Ferramentas" Aberta
floor_df <- rbind(iso(0,0,0), iso(1,0,0), iso(1,1,0), iso(0,1,0))
left_wall <- rbind(iso(0,1,0), iso(0,0,0), iso(0,0,1), iso(0,1,1))
right_wall <- rbind(iso(1,0,0), iso(0,0,0), iso(0,0,1), iso(1,0,1))

# 4. A Alça da Caixa de Ferramentas
h1 <- iso(0, 0.7, 1)     # Base esquerda
h2 <- iso(0, 0.7, 1.35)  # Sobe esquerda
h3 <- iso(0.7, 0, 1.35)  # Atravessa para a direita
h4 <- iso(0.7, 0, 1)     # Desce direita
handle_df <- data.frame(
  x = c(h1$x, h2$x, h3$x), y = c(h1$y, h2$y, h3$y),
  xend = c(h2$x, h3$x, h4$x), yend = c(h2$y, h3$y, h4$y)
)

# 5. Grade de Dados (Matriz) no fundo da caixa
grid_segs <- data.frame()
for(i in seq(0.2, 0.8, by=0.2)) {
  p1 <- iso(i, 0, 0); p2 <- iso(i, 1, 0)
  p3 <- iso(0, i, 0); p4 <- iso(1, i, 0)
  grid_segs <- rbind(grid_segs, 
                     data.frame(x=p1$x, y=p1$y, xend=p2$x, yend=p2$y),
                     data.frame(x=p3$x, y=p3$y, xend=p4$x, yend=p4$y))
}

# 6. Simulando "Ferramentas" (Dados 3D e Vetor de Regressão)
set.seed(42)
n <- 35
x_pts <- runif(n, 0.1, 0.9)
y_pts <- runif(n, 0.1, 0.9)
# O Modelo (Plano Linear)
z_hat <- 0.1 + 0.4 * x_pts + 0.3 * y_pts
# Adicionando ruído para criar os resíduos
z_pts <- z_hat + rnorm(n, 0, 0.15)

df_pts <- iso(x_pts, y_pts, z_pts)
df_floor <- iso(x_pts, y_pts, rep(0, n)) # Projeção no chão para dar efeito 3D

# O Vetor Forte de Ajuste Linear cruzando a caixa
p_start <- iso(0.1, 0.1, 0.1 + 0.4*0.1 + 0.3*0.1)
p_end <- iso(0.9, 0.9, 0.1 + 0.4*0.9 + 0.3*0.9)
df_line <- data.frame(x = p_start$x, y = p_start$y, xend = p_end$x, yend = p_end$y)

# 7. Renderização do Gráfico
ggplot() +
  # Borda do Sticker
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#121212", color = "#00B4D8", linewidth = 4) +
  
  # Faces Internas da Caixa (Paredes e Fundo)
  geom_polygon(data = left_wall, aes(x = x, y = y), fill = "#212529", color = NA) +
  geom_polygon(data = right_wall, aes(x = x, y = y), fill = "#343A40", color = NA) +
  geom_polygon(data = floor_df, aes(x = x, y = y), fill = "#1A1D20", color = NA) +
  
  # Arestas Estruturais da Caixa (O chassi)
  geom_polygon(data = left_wall, aes(x = x, y = y), fill = NA, color = "#6C757D", linewidth = 1) +
  geom_polygon(data = right_wall, aes(x = x, y = y), fill = NA, color = "#6C757D", linewidth = 1) +
  geom_polygon(data = floor_df, aes(x = x, y = y), fill = NA, color = "#6C757D", linewidth = 1) +
  
  # Alça da Caixa de Ferramentas (Prata/Aço)
  geom_segment(data = handle_df, aes(x = x, y = y, xend = xend, yend = yend), color = "#ADB5BD", linewidth = 2.5) +
  
  # Matriz / Grade no chão
  geom_segment(data = grid_segs, aes(x = x, y = y, xend = xend, yend = yend), color = "#495057", alpha = 0.6) +
  
  # Linhas de profundidade (ancorando os resíduos no chão da caixa)
  geom_segment(aes(x = df_floor$x, y = df_floor$y, xend = df_pts$x, yend = df_pts$y), color = "#6C757D", alpha = 0.5, linetype = "dotted") +
  
  # O Modelo (Vetor de Regressão - Laranja)
  geom_segment(data = df_line, aes(x = x, y = y, xend = xend, yend = yend), color = "#FCA311", linewidth = 2.5, arrow = arrow(length = unit(0.3, "cm"), type = "closed")) +
  
  # Os Dados (Pontos Ciano Brilhante flutuando na caixa)
  geom_point(data = df_pts, aes(x = x, y = y), color = "#00B4D8", size = 2.5, alpha = 0.9) +
  geom_point(data = df_pts, aes(x = x, y = y), color = "white", size = 0.8) +
  
  # Nome do pacote
  annotate("text", x = 0, y = -0.72, label = "regcore", color = "white", size = 13, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

# Hexágono Base
angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# 1. Criando os Radares da Interface Tática (HUD)
c1 <- data.frame(x = 0.35 * cos(seq(0, 2*pi, length.out=100)), y = 0.35 * sin(seq(0, 2*pi, length.out=100)))
c2 <- data.frame(x = 0.65 * cos(seq(0, 2*pi, length.out=100)), y = 0.65 * sin(seq(0, 2*pi, length.out=100)))

# 2. Simulando o "Escaner" de Dados
set.seed(101)
df_pts <- data.frame(x = runif(35, -0.6, 0.6))
df_pts$y <- 0.5 * df_pts$x + 0.1 + rnorm(35, 0, 0.15)

# 3. O Alvo "Travado" (O Modelo Selecionado)
target_idx <- 15
df_lock <- df_pts[target_idx, ]

# 4. O Disparo (A Reta do Modelo Vencedor)
df_line <- data.frame(x = c(-0.7, 0.7), y = c(0.5*-0.7+0.1, 0.5*0.7+0.1))

ggplot() +
  # Fundo Carbono Escuro com Borda Cinza Metálico
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#0D1117", color = "#444C56", linewidth = 4) +
  
  # Radares Concêntricos (Verde Tático)
  geom_path(data = c1, aes(x = x, y = y), color = "#2EA043", alpha = 0.3, linetype = "dashed") +
  geom_path(data = c2, aes(x = x, y = y), color = "#2EA043", alpha = 0.3, linetype = "dashed") +
  
  # Linhas da Mira (Crosshairs)
  geom_segment(aes(x = -0.75, xend = 0.75, y = 0, yend = 0), color = "#2EA043", alpha = 0.3) +
  geom_segment(aes(x = 0, xend = 0, y = -0.75, yend = 0.75), color = "#2EA043", alpha = 0.3) +
  
  # Outros pontos sendo analisados (Cinza/Desfocados)
  geom_point(data = df_pts[-target_idx, ], aes(x = x, y = y), color = "#8B949E", size = 2, alpha = 0.6) +
  
  # O Disparo do Modelo (Laser Vermelho)
  geom_line(data = df_line, aes(x = x, y = y), color = "#F85149", linewidth = 3, alpha = 0.3) +
  geom_line(data = df_line, aes(x = x, y = y), color = "#F85149", linewidth = 1.2) +
  
  # A Trava de Mira no Alvo Principal (Box tático)
  geom_rect(aes(xmin = df_lock$x - 0.08, xmax = df_lock$x + 0.08, ymin = df_lock$y - 0.08, ymax = df_lock$y + 0.08), fill = NA, color = "#F85149", linewidth = 1) +
  geom_point(data = df_lock, aes(x = x, y = y), color = "#F85149", size = 3.5) +
  
  # Nome (Fonte monoespaçada lembrando código/HUD militar)
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "white", size = 13, fontface = "bold", family = "mono") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# As vigas estruturais que dividem o Rack de ferramentas
rack <- data.frame(
  x = c(-0.75, 0), xend = c(0.75, 0),
  y = c(0.05, 0.75), yend = c(0.05, -0.55)
)

# Arma 1: Envelope (Topo-Esquerda)
x1 <- seq(-0.55, -0.05, length.out=20)
y_center <- 0.45 + (x1+0.3)^2 * 1.5
df_env <- data.frame(x = c(x1, rev(x1)), y = c(y_center+0.08, rev(y_center-0.08)))
df_env_line <- data.frame(x = x1, y = y_center)

# Arma 2: Vuong Test (Topo-Direita)
x2 <- c(0.1, 0.5)
v1 <- data.frame(x=x2, y=c(0.2, 0.6))
v2 <- data.frame(x=x2, y=c(0.5, 0.25))

# Arma 3: Random Effects (Fundo-Esquerda)
df_ranef <- data.frame(
  y = c(-0.15, -0.25, -0.35),
  xmin = c(-0.5, -0.55, -0.45),
  xmax = c(-0.2, -0.15, -0.25),
  est = c(-0.35, -0.3, -0.35)
)

# Arma 4: Step Selection (Fundo-Direita)
df_step <- data.frame(
  x = c(0.05, 0.15, 0.15, 0.25, 0.25, 0.35, 0.35, 0.45),
  y = c(-0.1, -0.1, -0.2, -0.2, -0.3, -0.3, -0.4, -0.4)
)

ggplot() +
  # Fundo Metálico Escuro (Estilo case de arsenal)
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#1E222A", color = "#4B5263", linewidth = 4) +
  
  # Vigas do Rack
  geom_segment(data = rack, aes(x = x, y = y, xend = xend, yend = yend), color = "#4B5263", linewidth = 3) +
  
  # --- Desenhando as Armas ---
  # Slot 1
  geom_polygon(data = df_env, aes(x = x, y = y), fill = "#00B4D8", alpha = 0.3) +
  geom_line(data = df_env_line, aes(x = x, y = y), color = "#00B4D8", linewidth = 1.2) +
  
  # Slot 2 (Destaque em Vermelho/Laranja para o modelo vencedor)
  geom_line(data = v2, aes(x = x, y = y), color = "#6C757D", linewidth = 1, linetype = "dashed") +
  geom_line(data = v1, aes(x = x, y = y), color = "#FCA311", linewidth = 1.5) +
  
  # Slot 3
  geom_segment(data = df_ranef, aes(x = xmin, xend = xmax, y = y, yend = y), color = "#00B4D8", linewidth = 1) +
  geom_point(data = df_ranef, aes(x = est, y = y), color = "#00B4D8", size = 2) +
  
  # Slot 4
  geom_path(data = df_step, aes(x = x, y = y), color = "#00B4D8", linewidth = 1.2) +
  
  # Título no rodapé
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "white", size = 13, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Função para projetar pontos 3D para 2D (isométrico)
iso <- function(x, y, z) {
  S <- 0.65 # Escala
  px <- (x - y) * 0.866 * S
  py <- -(x + y) * 0.5 * S + z * S - 0.2
  data.frame(x = px, y = py)
}

# Criando a grade base (os eixos X1 e X2)
grid_segs <- data.frame()
for(i in seq(-1, 1, by=0.4)) {
  p1 <- iso(i, -1, 0); p2 <- iso(i, 1, 0)
  p3 <- iso(-1, i, 0); p4 <- iso(1, i, 0)
  grid_segs <- rbind(grid_segs, 
                     data.frame(x=p1$x, y=p1$y, xend=p2$x, yend=p2$y),
                     data.frame(x=p3$x, y=p3$y, xend=p4$x, yend=p4$y))
}

# Dados Simulados (Pontos e Resíduos)
set.seed(33)
n <- 25
x1_pts <- runif(n, -0.9, 0.9)
x2_pts <- runif(n, -0.9, 0.9)
# Plano ajustado (Efeito fixo puro)
z_hat <- 0.3 + 0.4 * x1_pts + 0.2 * x2_pts
z_pts <- z_hat + rnorm(n, 0, 0.3) # Ruído

df_hat <- iso(x1_pts, x2_pts, z_hat)
df_pts <- iso(x1_pts, x2_pts, z_pts)

# Desenhando o próprio plano de regressão (superfície translúcida)
p_plane1 <- iso(-1, -1, 0.3 + 0.4*(-1) + 0.2*(-1))
p_plane2 <- iso(1, -1, 0.3 + 0.4*(1) + 0.2*(-1))
p_plane3 <- iso(1, 1, 0.3 + 0.4*(1) + 0.2*(1))
p_plane4 <- iso(-1, 1, 0.3 + 0.4*(-1) + 0.2*(1))
df_plane <- data.frame(
  x = c(p_plane1$x, p_plane2$x, p_plane3$x, p_plane4$x),
  y = c(p_plane1$y, p_plane2$y, p_plane3$y, p_plane4$y)
)

ggplot() +
  # Fundo noturno acadêmico (Azul Escuro/Cinza)
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#1C2833", color = "#5D6D7E", linewidth = 4) +
  
  # A Grade Base (X)
  geom_segment(data = grid_segs, aes(x = x, y = y, xend = xend, yend = yend), color = "#34495E", alpha = 0.8) +
  
  # As Linhas de Resíduo (A essência da regressão, ligando os pontos ao plano)
  geom_segment(aes(x = df_hat$x, y = df_hat$y, xend = df_pts$x, yend = df_pts$y), color = "#BDC3C7", alpha = 0.6, linetype = "dashed") +
  
  # O Plano de Regressão em si (Cor Dourada/Laranja translúcida)
  geom_polygon(data = df_plane, aes(x = x, y = y), fill = "#F39C12", alpha = 0.2, color = "#F39C12", linewidth = 1) +
  
  # Os Pontos de Dados
  geom_point(data = df_pts, aes(x = x, y = y), color = "#3498DB", size = 2.5) +
  geom_point(data = df_pts, aes(x = x, y = y), color = "white", size = 0.8) +
  
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "white", size = 13, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))

library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Construindo uma Engrenagem (Gear) usando trigonometria
t <- seq(0, 2 * pi, length.out = 400)
# Criando os "dentes" da engrenagem usando a função sign(sin())
r_gear <- 0.5 + 0.06 * sign(sin(10 * t))
df_gear <- data.frame(x = r_gear * cos(t), y = r_gear * sin(t))
df_gear_inner <- data.frame(x = 0.35 * cos(t), y = 0.35 * sin(t)) # Vazado interno

# Dados e Regressão cortando o núcleo da engrenagem
set.seed(8)
x_pts <- runif(35, -0.4, 0.4)
y_pts <- 0.8 * x_pts + rnorm(35, 0, 0.08)
df_pts <- data.frame(x = x_pts, y = y_pts)
df_line <- data.frame(x = c(-0.5, 0.5), y = c(-0.4, 0.4))

ggplot() +
  # Fundo escuro
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#181A1B", color = "#00ADB5", linewidth = 4) +
  
  # A Engrenagem Externa e Interna (O 'Core')
  geom_polygon(data = df_gear, aes(x = x, y = y), fill = "#393E46", color = "#222831", linewidth = 1) +
  geom_polygon(data = df_gear_inner, aes(x = x, y = y), fill = "#181A1B") + # Fazendo o "furo" da engrenagem
  
  # Os Resíduos e os Dados
  geom_segment(data = df_pts, aes(x = x, y = y, xend = x, yend = 0.8 * x), color = "#EEEEEE", alpha = 0.5, linetype = "dotted") +
  geom_point(data = df_pts, aes(x = x, y = y), color = "#00ADB5", size = 2) +
  
  # A Reta de Regressão cruzando a máquina
  geom_line(data = df_line, aes(x = x, y = y), color = "#00ADB5", linewidth = 2.5) +
  
  # Nome
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "#EEEEEE", size = 13, fontface = "bold", family = "sans") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))

library(ggplot2)

angles <- (seq(1, 11, by = 2) * pi) / 6
hex_df <- data.frame(x = cos(angles), y = sin(angles))

# Grade arquitetônica (Blueprint Grid)
grid_segs <- data.frame()
for(i in seq(-0.7, 0.7, by=0.1)) {
  grid_segs <- rbind(grid_segs, data.frame(x=i, y=-0.7, xend=i, yend=0.7)) # Verticais
  grid_segs <- rbind(grid_segs, data.frame(x=-0.7, y=i, xend=0.7, yend=i)) # Horizontais
}

# Dados de Regressão
set.seed(42)
x_pts <- runif(30, -0.5, 0.5)
y_pts <- 0.6 * x_pts + rnorm(30, 0, 0.1)
df_pts <- data.frame(x = x_pts, y = y_pts)
df_line <- data.frame(x = c(-0.6, 0.6), y = c(-0.36, 0.36))

# Elementos técnicos (como se fosse um desenho CAD)
cad_marks <- data.frame(
  x = c(-0.6, -0.6, 0.6, 0.6),
  y = c(0.4, 0.5, -0.4, -0.5),
  xend = c(-0.5, -0.6, 0.5, 0.6),
  yend = c(0.4, 0.4, -0.4, -0.4)
)

ggplot() +
  # Fundo Azul Blueprint
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#0D47A1", color = "#FFFFFF", linewidth = 3) +
  
  # A Grade Milimetrada
  geom_segment(data = grid_segs, aes(x = x, y = y, xend = xend, yend = yend), color = "#FFFFFF", alpha = 0.2, linewidth = 0.3) +
  
  # Marcações de Desenho Técnico
  geom_segment(data = cad_marks, aes(x = x, y = y, xend = xend, yend = yend), color = "#FFFFFF", linewidth = 0.8) +
  
  # A Nuvem de Dispersão (Dados brutos)
  geom_point(data = df_pts, aes(x = x, y = y), color = "#90CAF9", size = 2.5, shape = 1) +
  
  # A Reta de Ajuste
  geom_line(data = df_line, aes(x = x, y = y), color = "#FFFFFF", linewidth = 2) +
  
  # Equação matemática no fundo (abstrata)
  annotate("text", x = -0.3, y = 0.5, label = "y = Xβ + ε", color = "#FFFFFF", alpha = 0.5, size = 6, family = "mono") +
  
  # Nome
  annotate("text", x = 0, y = -0.75, label = "regcore", color = "#FFFFFF", size = 12, fontface = "bold", family = "mono") +
  
  coord_fixed() + theme_void() + theme(plot.background = element_rect(fill = "transparent", color = NA))


###############################################################################
## regcore R package: Hexagon Sticker (Cube + Regression + Ocean Tech)
## Author: Ricardo Rasmussen Petterle - UFPR
## Date: August 12, 2026
###############################################################################

library(ggplot2)

# 1. Vértices do Hexágono (Ponta para cima, padrão CRAN)
angles <- (seq(1, 11, by = 2) * pi) / 6
vx <- cos(angles)
vy <- sin(angles)

# 2. Construindo as 3 faces do cubo 3D isométrico
face_top <- data.frame(x = c(0, vx[3], vx[2], vx[1]), y = c(0, vy[3], vy[2], vy[1]))
face_left <- data.frame(x = c(0, vx[3], vx[4], vx[5]), y = c(0, vy[3], vy[4], vy[5]))
face_right <- data.frame(x = c(0, vx[5], vx[6], vx[1]), y = c(0, vy[5], vy[6], vy[1]))
hex_df <- data.frame(x = vx, y = vy)

# 3. Efeito "Ocean Snow" (Estilo unitregTMB)
set.seed(101)
n_snow <- 1500
ocean_snow <- data.frame(
  x = runif(n_snow, -1, 1), y = runif(n_snow, -1, 1),
  size = runif(n_snow, 0.05, 0.7), alpha = runif(n_snow, 0.1, 0.45)
)
# Mantendo a neve dentro dos limites do hexágono
ocean_snow <- subset(ocean_snow, x^2 + y^2 < 0.85)

# 4. Estrutura da Regressão (Reta Linear + Envelope) atravessando o núcleo
x_curve <- seq(-0.75, 0.75, length.out = 400)
y_center <- 0.35 * x_curve + 0.15
y_se <- 0.07 * sqrt(1 + 4 * x_curve^2) # Formato clássico de envelope (mais largo nas pontas)

df_curve <- data.frame(
  x = x_curve, 
  y = y_center, 
  y_lower = y_center - y_se, 
  y_upper = y_center + y_se
)

# 5. Dados Simulados e Resíduos
set.seed(42)
n_pts <- 35
x_data <- runif(n_pts, -0.7, 0.7)
y_data <- 0.35 * x_data + 0.15 + rnorm(n_pts, 0, 0.08)

df_data <- data.frame(
  x = x_data, 
  y = y_data, 
  y_hat = 0.35 * x_data + 0.15
)

# 6. O Plot
p <- ggplot() +
  
  # Borda externa do Hexágono (Neon/Cyan)
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#000814", color = "#48CAE4", linewidth = 4) +
  
  # Faces do Cubo (Tons de Azul Oceânico Profundo para dar o efeito 3D)
  geom_polygon(data = face_top, aes(x = x, y = y), fill = "#002B49", color = NA) +
  geom_polygon(data = face_left, aes(x = x, y = y), fill = "#000814", color = NA) +
  geom_polygon(data = face_right, aes(x = x, y = y), fill = "#001228", color = NA) +
  
  # Arestas internas do cubo (O "Chassi" da infraestrutura S3)
  geom_segment(aes(x = 0, y = 0, xend = vx[1], yend = vy[1]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  geom_segment(aes(x = 0, y = 0, xend = vx[3], yend = vy[3]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  geom_segment(aes(x = 0, y = 0, xend = vx[5], yend = vy[5]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  
  # Adicionando o Ocean Snow
  geom_point(data = ocean_snow, aes(x = x, y = y, size = size, alpha = alpha), color = "#E0FFFF", shape = 16) +
  scale_size_identity() + scale_alpha_identity() +
  
  # Banda de Confiança (Envelope) preenchida com o gradiente característico
  # geom_segment(data = df_curve, aes(x = x, xend = x, y = y_lower, yend = y_upper, color = x), alpha = 0.5) +
  # scale_color_gradient(low = "#002B49", high = "#00E5FF", guide = "none") +
  
  # Resíduos da Regressão (Conectando os dados à reta)
  # geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "#48CAE4", alpha = 0.6, linetype = "dotted") +
  
  # Pontos de Dados
  # geom_point(data = df_data, aes(x = x, y = y), color = "#00E5FF", size = 2, alpha = 0.9) +
  # geom_point(data = df_data, aes(x = x, y = y), color = "white", size = 0.7) +
  
  # A Reta de Regressão Mestra (Com brilho neon)
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#00E5FF", linewidth = 3, alpha = 0.3) +
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#FFFFFF", linewidth = 1.2) +
  
  # Título e Subtítulo
  annotate("text", x = 0, y = -0.65, label = "regcore", color = "#FFFFFF", size = 13, fontface = "bold", family = "sans") +
  annotate("text", x = 0, y = -0.80, label = "S3 Methods for Regression", color = "#48CAE4", size = 4.2, fontface = "bold", family = "sans") +
  
  coord_fixed(xlim = c(-1.05, 1.05), ylim = c(-1.05, 1.05)) + 
  theme_void() + 
  theme(plot.background = element_rect(fill = "transparent", color = NA))

p

## Salvar a imagem
# ggsave("Logo_regcore_cube.png", p, width = 6.35, height = 5.53, bg = "transparent", dpi = 300)


###############################################################################
## regcore R package: Hexagon Sticker (Cube + Regression + 3D Text)
## Author: Ricardo Rasmussen Petterle - UFPR
## Date: August 12, 2026
###############################################################################

library(ggplot2)

# 1. Vértices do Hexágono (Ponta para cima, padrão CRAN)
angles <- (seq(1, 11, by = 2) * pi) / 6
vx <- cos(angles)
vy <- sin(angles)

# 2. Construindo as 3 faces do cubo 3D isométrico
face_top <- data.frame(x = c(0, vx[3], vx[2], vx[1]), y = c(0, vy[3], vy[2], vy[1]))
face_left <- data.frame(x = c(0, vx[3], vx[4], vx[5]), y = c(0, vy[3], vy[4], vy[5]))
face_right <- data.frame(x = c(0, vx[5], vx[6], vx[1]), y = c(0, vy[5], vy[6], vy[1]))
hex_df <- data.frame(x = vx, y = vy)

# 3. Efeito "Ocean Snow" (Estilo unitregTMB)
set.seed(101)
n_snow <- 1500
ocean_snow <- data.frame(
  x = runif(n_snow, -1, 1), y = runif(n_snow, -1, 1),
  size = runif(n_snow, 0.05, 0.7), alpha = runif(n_snow, 0.1, 0.45)
)
# Mantendo a neve dentro dos limites do hexágono
ocean_snow <- subset(ocean_snow, x^2 + y^2 < 0.85)

# 4. Estrutura da Regressão (Reta Linear + Envelope) atravessando o núcleo
x_curve <- seq(-0.75, 0.75, length.out = 400)
y_center <- 0.35 * x_curve + 0.15
y_se <- 0.07 * sqrt(1 + 4 * x_curve^2) # Formato clássico de envelope

df_curve <- data.frame(
  x = x_curve, 
  y = y_center, 
  y_lower = y_center - y_se, 
  y_upper = y_center + y_se
)

# 5. Dados Simulados e Resíduos
set.seed(42)
n_pts <- 35
x_data <- runif(n_pts, -0.7, 0.7)
y_data <- 0.35 * x_data + 0.15 + rnorm(n_pts, 0, 0.08)

df_data <- data.frame(
  x = x_data, 
  y = y_data, 
  y_hat = 0.35 * x_data + 0.15
)

# 6. O Plot
p <- ggplot() +
  
  # Borda externa do Hexágono (Neon/Cyan)
  geom_polygon(data = hex_df, aes(x = x, y = y), fill = "#000814", color = "#48CAE4", linewidth = 4) +
  
  # Faces do Cubo (Tons de Azul Oceânico Profundo para dar o efeito 3D)
  geom_polygon(data = face_top, aes(x = x, y = y), fill = "#002B49", color = NA) +
  geom_polygon(data = face_left, aes(x = x, y = y), fill = "#000814", color = NA) +
  geom_polygon(data = face_right, aes(x = x, y = y), fill = "#001228", color = NA) +
  
  # Arestas internas do cubo (O "Chassi" da infraestrutura S3)
  geom_segment(aes(x = 0, y = 0, xend = vx[1], yend = vy[1]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  geom_segment(aes(x = 0, y = 0, xend = vx[3], yend = vy[3]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  geom_segment(aes(x = 0, y = 0, xend = vx[5], yend = vy[5]), color = "#00BFFF", linewidth = 0.5, alpha = 0.5) +
  
  # Adicionando o Ocean Snow
  geom_point(data = ocean_snow, aes(x = x, y = y, size = size, alpha = alpha), color = "#E0FFFF", shape = 16) +
  scale_size_identity() + scale_alpha_identity() +
  
  # Banda de Confiança (Envelope) preenchida com o gradiente característico
  # geom_segment(data = df_curve, aes(x = x, xend = x, y = y_lower, yend = y_upper, color = x), alpha = 0.5) +
  # scale_color_gradient(low = "#002B49", high = "#00E5FF", guide = "none") +
  
  # Resíduos da Regressão (Conectando os dados à reta)
  # geom_segment(data = df_data, aes(x = x, y = y, xend = x, yend = y_hat), color = "#48CAE4", alpha = 0.6, linetype = "dotted") +
  
  # Pontos de Dados
  # geom_point(data = df_data, aes(x = x, y = y), color = "#00E5FF", size = 2, alpha = 0.9) +
  # geom_point(data = df_data, aes(x = x, y = y), color = "white", size = 0.7) +
  
  # A Reta de Regressão Mestra (Com brilho neon)
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#00E5FF", linewidth = 3, alpha = 0.3) +
  # geom_line(data = df_curve, aes(x = x, y = y), color = "#FFFFFF", linewidth = 1.2) +
  
  # ---------------------------------------------------------
# EFEITO TEXTO 3D COLADO NO CUBO (regcore)
# Metade "reg" na face esquerda (inclinado pra cima, alinhado à direita)
annotate("text", x = -0.015, y = -0.25, label = "reg", color = "#00E5FF", 
         size = 15, fontface = "bold", family = "sans", angle = -14, hjust = 1) +
  
  # Metade "core" na face direita (inclinado pra baixo, alinhado à esquerda)
  annotate("text", x = 0.015, y = -0.25, label = "core", color = "#00E5FF", 
           size = 15, fontface = "bold", family = "sans", angle = 15, hjust = 0) +
  # ---------------------------------------------------------

# Subtítulo (Mantido plano na base para ancorar a imagem)
annotate("text", x = 0, y = -0.78, label = "S3 Methods for Regression", color = "#48CAE4", size = 4.2, fontface = "bold", family = "sans") +
  
  coord_fixed(xlim = c(-1.05, 1.05), ylim = c(-1.05, 1.05)) + 
  theme_void() + 
  theme(plot.background = element_rect(fill = "transparent", color = NA))

p

## Salvar a imagem
# ggsave("Logo_regcore_cube_3Dtext.png", p, width = 6.35, height = 5.53, bg = "transparent", dpi = 300)