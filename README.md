# COVID-19 Global Data Analysis & Visualization

## Project Overview

This project analyzes global COVID-19 cases, deaths, and vaccination trends using MySQL, Python, and Tableau.

The project began with raw COVID-19 datasets obtained from Our World in Data and involved data cleaning, validation, database integration, exploratory SQL analysis, and dashboard development.

A key focus of this project was ensuring data integrity throughout the ETL process before performing analytical and visualization tasks.

---

## Objectives

This project aimed to answer the following questions:

1. What was the likelihood of death after contracting COVID-19?
2. Which countries experienced the highest infection rates?
3. Which countries experienced the highest death rates relative to population?
4. How did infection rates evolve over time?
5. How did vaccination adoption progress across countries?
6. What global patterns emerged throughout the pandemic?

---

## Tools & Technologies

* MySQL
* Python
* Pandas
* SQLAlchemy
* Tableau

---

## Data Source

The COVID-19 datasets used in this project were obtained from "Our World in Data", a widely used open-access data platform that aggregates global COVID-19 case, death, and vaccination statistics. The project uses the downloadable COVID-19 datasets provided through their COVID Data Explorer and data repository.

---

## Acknowledgements

This project was inspired by the SQL and Tableau portfolio project created by Alex The Analyst.

While the original tutorial provided the project framework, I worked with a newer version of the COVID-19 dataset and independently addressed data ingestion, schema alignment, data validation, ETL development using Pandas and SQLAlchemy, and dashboard customization.

---

## Project Workflow

### Step 1: Data Acquisition

Downloaded the latest COVID-19 datasets.

Initial challenges included:

* Dataset schema differences compared with the tutorial version
* Missing columns in newer datasets
* Raw endpoint format instead of preformatted CSV files

---

### Step 2: Data Cleaning and Validation

Performed data cleaning using Python and Pandas.

Tasks included:

* Replacing blank values
* Standardizing missing values
* Handling "NA", "N/A", and "unknown" entries
* Validating column consistency
* Maintaining schema compatibility

Example:

```python
df = df.replace(r'^\s*$', pd.NA, regex=True)
df = df.replace(["NA", "N/A", "na", "n/a", "unknown"], pd.NA)
df = df.where(pd.notna(df), None)
```

---

### Step 3: Database Integration

Instead of relying on manual CSV imports, a reproducible ETL workflow was developed using SQLAlchemy.

Workflow:

CSV → Pandas → Data Cleaning → SQLAlchemy → MySQL

Benefits:

* Better reliability
* Easier maintenance
* Repeatable data loading process
* Explicit datatype control

Example:

```python
engine = create_engine(
    "mysql+pymysql://username:password@host/database"
)
```

---

### Step 4: Data Integrity Verification

During import, a discrepancy was identified:

* Original dataset: 565,378 rows
* Imported dataset: 538,996 rows

More than 26,000 records were missing.

Investigation revealed datatype mismatches during import.

For example:

* Numeric columns occasionally contained string values such as "unknown"
* MySQL rejected those rows
* Records were skipped during loading

To resolve this issue:

* Dataset schemas were reviewed
* Missing values were standardized
* Datatypes were explicitly defined
* Row-count reconciliation was performed

This ensured accurate database records before analysis.

---

## SQL Analysis

### Data Exploration

Validated:

* Null values
* Population records
* Country coverage
* Continent classifications

---

### Case Fatality Rate

Calculated the likelihood of death after infection:

```sql
(total_deaths / total_cases) * 100
```

---

### Infection Rate Analysis

Calculated the percentage of each country's population infected:

```sql
(total_cases / population) * 100
```

---

### Country-Level Comparisons

Identified:

* Countries with the highest total infections
* Countries with the highest infection rates
* Countries with the highest death rates

---

### Global Trend Analysis

Aggregated daily worldwide cases and deaths:

```sql
SUM(new_cases)
SUM(new_deaths)
```

to calculate global mortality trends.

---

### Vaccination Analysis

Joined case and vaccination datasets:

```sql
JOIN covid_vaccinations
ON location AND date
```

Used window functions to calculate cumulative vaccinations:

```sql
SUM(new_vaccinations)
OVER (
    PARTITION BY location
    ORDER BY date
)
```

---

### Advanced SQL Concepts Demonstrated

* Aggregate Functions
* GROUP BY
* ORDER BY
* INNER JOIN
* Window Functions
* Common Table Expressions (CTEs)
* Temporary Tables
* Data Transformation

---

## Tableau Dashboard

Interactive dashboard built in Tableau analyzing global COVID-19 trends.

👉 [View Live Dashboard](https://public.tableau.com/shared/Q9KTRC7P7?:display_count=n&:origin=viz_share_link)

### Global Overview

* Total Cases
* Total Deaths
* Death Percentage

### Geographic Analysis

* Death Count by Continent
* Infection Rate by Country

### Time Series Analysis

* Infection Rate Over Time
* Pandemic Growth Trends

### Vaccination Analysis

* Rolling Vaccination Counts
* Vaccination Progress by Country

---

## Key Findings

### Infection Counts

The United States reported the highest total number of confirmed COVID-19 cases.

### Infection Rates

Several smaller countries exhibited higher infection rates when adjusted for population size.

### Mortality Rates

Peru recorded one of the highest COVID-19 death rates relative to population.

### Regional Differences

Substantial variation existed across continents in both infection and mortality outcomes.

### Vaccination Trends

Vaccination adoption rates varied significantly across countries and regions.

---

## Challenges and Lessons Learned

This project provided practical experience beyond SQL analysis.

Key lessons included:

* Diagnosing failed database imports
* Validating row-count consistency
* Resolving datatype mismatches
* Building reproducible ETL workflows
* Preparing datasets for BI tools
* Ensuring data quality before analysis

The most valuable takeaway was learning that data preparation and validation often require more effort than the analysis itself.
