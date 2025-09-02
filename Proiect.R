set.seed(123)

# 1. Modelarea variabilelor aleatoare relevante
zile <- 90 # simulam 90 de zile

# Magazin 1
# Cerere zilnica pentru fiecare produs din magazinul 1
produs1_m1 <- rpois(zile, lambda = 8)      # Poisson - produs vandut rapid
produs2_m1 <- rbinom(zile, size = 20, prob = 0.3)  # Binomiala - produs vandut moderat
produs3_m1 <- rexp(zile, rate = 1/5)       # Exponentiala - produs cu cere variabila

# Magazin 2
# Cerere zilnica pentru fiecare produs din magazinul 2
produs1_m2 <- rpois(zile, lambda = 7)
produs2_m2 <- rbinom(zile, size = 20, prob = 0.4)
produs3_m2 <- rexp(zile, rate = 1/4)

# Timp de livrare (Gamma - continua, pozitiva)
timp_livrare <- rgamma(zile, shape = 2, rate = 0.5)

# Produse defecte la receptie (Binomiala)
produse_defecte <- rbinom(zile, size = 30, prob = 0.05)

# 2. Analiza bidimensionala si relatii intre variabile

# Corelatia dintre 2 produse din acelasi magazin
cor(produs1_m1, produs2_m1)
plot(produs1_m1, produs2_m1, main="Corelatie intre produs1 si produs2 in Magazin 1")
covarianta <- cov(produs1_m1, produs2_m1)
cat("Covarianta dintre produs1 si produs2 in magazinul 1 este:", covarianta, "\n")

# Corelatia intre cerere si timpul de livrare
cor(produs1_m1, timp_livrare)
plot(produs1_m1, timp_livrare, main="Cerere vs Timp de livrare")
cov_cerere_livrare <- cov(produs1_m1, timp_livrare)
cat("Covarianta intre cerere si timpul de livrare:", cov_cerere_livrare, "\n")

# Repartitii marginale
hist(produs1_m1, main="Distributie marginala: Produs1 Magazin1", col="skyblue")
hist(timp_livrare, main="Distributie marginala: Timp livrare", col="salmon")

# Repartitii conditionate
# Impartim cererea in 3 categorii: mica, medie, mare
categorie_cerere <- cut(produs1_m1,
                        breaks = quantile(produs1_m1, probs = c(0, 0.33, 0.66, 1)),
                        labels = c("Mica", "Medie", "Mare"),
                        include.lowest = TRUE)

# Timpul de livrare conditionat pe cerere
boxplot(timp_livrare ~ categorie_cerere,
        main = "Distributie conditionata: Timp livrare in functie de cerere",
        xlab = "Categorie cerere",
        ylab = "Timp livrare",
        col = c("lightgreen", "lightblue", "orange"))
# Interpretare practica: timpul de livrare creste odata cu cererea, inseamna ca cele doua sunt dependente.

# Test de independenta
# Discretizam ambele variabile
cut_cerere <- cut(produs1_m1, breaks = 4)
cut_timp <- cut(timp_livrare, breaks = 4)

# Construim tabelul de contingenta
tabel <- table(cut_cerere, cut_timp)

# Aplicam testul chi²
test_chi2 <- chisq.test(tabel)
print(test_chi2)

# Interpretare practica: 
# Daca p-value < 0.05, exista dependenta statistic semnificativa intre variabile.
# Daca p-value ≥ 0.05, nu putem afirma ca sunt dependente — pot fi independente.

# 3. Sume si transformari de variabile aleatoare

# Suma cereri pentru acelasi produs in cele doua magazine
suma_cerere_p1 <- produs1_m1 + produs1_m2
hist(suma_cerere_p1, main="Suma cererii pentru produs1", col="orange")

# Total defecte pentru toate produsele intr-o zi
defecte_totale <- produse_defecte + rbinom(zile, 30, 0.05) + rbinom(zile, 30, 0.05)

hist(defecte_totale, breaks = 15, col = "steelblue", main = "Distributia totala a defectelor intr-o zi",
     xlab = "Numar total de produse defecte")

# Media si deviatia standard
mean(defecte_totale)
sd(defecte_totale)

# QQ-plot pentru normalitate
qqnorm(defecte_totale)
qqline(defecte_totale, col = "red")
# QQ-plot-ul aproape liniar → aproximam distributia sumei ca Normala.

# Test de normalitate (Shapiro-Wilk)
shapiro.test(defecte_totale)
# Daca shapiro.test() are p > 0.05 → nu respingi normalitatea.

# Timp total de livrare pentru 2 produse (suma Gamma)
timp_total <- rgamma(zile, shape = 4, rate = 0.5)  # suma a doua Gamma(2,0.5)

zile <- 1000
t1 <- rgamma(zile, shape = 2, rate = 0.5)
t2 <- rgamma(zile, shape = 2, rate = 0.5)
timp_total <- t1 + t2

# Compara empiric vs teoretic
hist(timp_total, breaks = 50, probability = TRUE, col = "skyblue", main = "Suma Gamma(2, 0.5) + Gamma(2, 0.5)")
curve(dgamma(x, shape = 4, rate = 0.5), col = "red", lwd = 2, add = TRUE)
legend("topright", legend = c("Teoretic Gamma(4, 0.5)"), col = "red", lwd = 2)

cerere_produs1_total <- produs1_m1 + produs1_m2
# Aceasta suma este distribuita aproximativ ca Poisson(15)
# produs1_m1 ~ Poisson(8)
# produs1_m2 ~ Poisson(7)
# ⇒ suma ~ Poisson(8 + 7) = Poisson(15)

# 4. Aplicatii ale inegalitatilor probabilistice

# Aplicarea inegalitatii lui Cebisev
media <- mean(produs1_m1)
devst <- sd(produs1_m1)

k <- (media - 5) / devst
prob_cebisev <- 1 / (k^2)
cat("Probabilitatea (aproximativ) sa scada sub 5 bucati:", prob_cebisev, "\n")

# Inegalitatea lui Jensen: E[f(X)] ≥ f(E[X]) pentru functii convexe
stoc <- produs1_m1
mean_stoc_squared <- mean(stoc^2)
# (mean_stoc)^2  # Comparam cu mean_stoc_squared

# Bonus Inegalitatea lui Hoeffding
# Suma zilnica a cererii pentru produs1
cerere_totala_p1 <- produs1_m1 + produs1_m2  # aproximativ Poisson(15)

# Estimam empiric media cererii zilnice
media_cerere <- mean(cerere_totala_p1)

# Presupunem ca produsul este cerut de 90 de clienti in total (n = 90 variabile)
n <- 90
a <- 0  # cerere minima per client
b <- 1  # cerere maxima per client

# Vrem sa estimam riscul ca suma cererii sa depaseasca stocul
stoc <- 300
t <- stoc - n * media_cerere / n  # diferenta fata de media totala estimata

# Aplicam inegalitatea lui Hoeffding
hoeffding_bound <- exp(-2 * (t^2) / (n * (b - a)^2))
cat("Probabilitatea ca cererea sa depaseasca stocul (estimare Hoeffding):", hoeffding_bound, "\n")

# 5. Vizualizare si interpretare practica

# Vizualizare completa
par(mfrow=c(2,3))
hist(produs1_m1, col="lightblue", main="Produs 1 - Magazin 1", xlab="Cantitate")
hist(produs1_m2, col="lightgreen", main="Produs 1 - Magazin 2", xlab="Cantitate")
hist(timp_livrare, col="lightpink", main="Timp livrare", xlab="Zile")

# Heatmap pentru cererea comuna Produs1 M1 vs M2
heatmap(table(produs1_m1, produs1_m2),
        Rowv = NA, Colv = NA, col = heat.colors(256),
        main = "Heatmap: Cerere Produs 1 (M1 vs M2)")

# Matrice corelatii + diagrama
mat <- data.frame(produs1_m1, produs2_m1, produs3_m1, timp_livrare)
cor_mat <- cor(mat)
heatmap(cor_mat, col = terrain.colors(10), main = "Matrice corelatie")

# Scatterplot intre produs1 si produs2 in Magazin 1
plot(produs1_m1, produs2_m1,
     xlab="Produs 1", ylab="Produs 2", main="Corelatie: Produs1 vs Produs2 M1", col="darkblue")

# Functie pentru simulare interactiva a cererii si stocului
simuleaza_stocuri <- function(lambda = 8, stoc_initial = 300, zile = 30) {
  cerere <- rpois(zile, lambda)
  stoc_ram <- stoc_initial - cumsum(cerere)
  stoc_ram[stoc_ram < 0] <- 0
  
  plot(stoc_ram, type = "l", lwd=2, col = "darkred",
       main = paste("Simulare stoc - Lambda:", lambda, "| Stoc initial:", stoc_initial),
       xlab = "Zi", ylab = "Stoc ramas")
  abline(h = 0, col = "gray", lty=2)
}
simuleaza_stocuri(lambda = 10, stoc_initial = 350, zile = 45)
