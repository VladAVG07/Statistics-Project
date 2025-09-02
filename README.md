# Inventory Demand Simulation with Probability and Statistics

This project models and analyzes the **random behavior of demand,
deliveries, and product defects** in a retail supply chain using
**probability distributions and statistical methods** in **R**.\
It was developed as part of the *Probabilities and Statistics* course at
the University of Bucharest, Faculty of Mathematics and Computer
Science.

------------------------------------------------------------------------

## 📌 Project Overview

The goal of the simulation is to better understand:

-   Daily **demand for products** in different stores.
-   **Delivery times** and their variability.
-   **Defective products** upon reception.
-   Relationships between variables such as demand and delivery.
-   Application of **probabilistic inequalities** to estimate risks in
    stock management.
-   Visualization of demand and supply chain behavior.

This provides practical insights for **inventory management**, **supply
chain optimization**, and **risk assessment**.

------------------------------------------------------------------------

## 🔧 Features and Methodology

### 1. Random Variable Modeling

-   **Store 1**
    -   Product 1: Poisson (fast-selling product)
    -   Product 2: Binomial (moderate demand)
    -   Product 3: Exponential (variable demand)
-   **Store 2**
    -   Similar distributions with slightly different parameters.
-   **Delivery Time**: Gamma distribution (positive, continuous).
-   **Defective Products**: Binomial distribution (with 5% defect
    probability).

### 2. Bivariate Analysis

-   **Correlations and covariances** between products.
-   **Demand vs Delivery time** (weak but positive correlation).
-   **Marginal and conditional distributions**.
-   **Chi-squared independence test** between discretized variables.

### 3. Operations on Random Variables

-   Sums of Poisson and Binomial variables.
-   Aggregated defect counts (tested for normality with Shapiro-Wilk).
-   Sums of Gamma-distributed delivery times.
-   Applications of the **Central Limit Theorem**.

### 4. Probabilistic Inequalities

-   **Chebyshev** -- bounds on deviation probabilities.
-   **Jensen** -- convexity-based analysis for stock cost volatility.
-   **Hoeffding** -- risk estimation of stockouts.

### 5. Visualization

-   Histograms of demand and delivery times.

-   Scatterplots and covariance diagrams.

-   Heatmaps of joint demand and correlation matrices.

-   Boxplots for conditional analysis.

-   Interactive stock simulation function:

    ``` r
    simuleaza_stocuri(lambda = 10, stoc_initial = 350, zile = 45)
    ```

    → Shows stock depletion risk over time.

------------------------------------------------------------------------

## 📊 Example Outputs

-   Demand histograms for each store.
-   Delivery time distribution (Gamma).
-   Heatmap of joint demand for Product 1 across stores.
-   Correlation matrix between products and delivery time.
-   QQ-plot for defect totals (approx. normality).
-   Stock simulation curve showing days with zero inventory.

------------------------------------------------------------------------

## 🚀 How to Run

1.  Clone this repository:

    ``` bash
    git clone https://github.com/your-username/inventory-simulation.git
    ```

2.  Open the R script in RStudio or run directly in R.

3.  Install required packages (base R is mostly sufficient).

4.  Run the script to generate results and plots.

------------------------------------------------------------------------

## 📚 Practical Insights

-   Weak correlation between demand for different products → independent
    stock policies may apply.
-   Delivery time slightly increases with higher demand → logistic
    delays possible.
-   Defective products follow an almost normal distribution due to
    aggregation.
-   Stockout risks can be **bounded with Hoeffding's inequality**,
    showing very low probability under normal demand.

------------------------------------------------------------------------

## 🏫 Credits

**University of Bucharest** -- Faculty of Mathematics and Computer
Science\
**Course:** Probabilities and Statistics\
**Team:**\
- Florescu Teodor-Ștefănuț\
- Apostol Vlad Gabriel\
- Cojoaca Alexandru\
- Stoica Vlad\
**Coordinator:** Dr. Cojocea Manuela-Simona

------------------------------------------------------------------------

## 📄 License

This project is for educational and research purposes.
