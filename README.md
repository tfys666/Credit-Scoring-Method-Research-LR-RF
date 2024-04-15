# Credit Scoring Method Research Based on Logistic Regression and Random Forest Models
﻿
Credit scoring predicts credit default by analyzing individual information, assisting financial institutions in making scientific decisions and ensuring the robust operation of the financial system. This code uses logistic regression and random forest models to model credit card application approvals, comparing the effectiveness and prediction accuracy of the two methods.
﻿
## Data Introduction
The dataset used in this study is a cleaned version of the "Credit Approval" dataset from the UCI Machine Learning Repository. This dataset is further enhanced and cleaned, with missing values filled and feature names and categorical names inferred to provide more context and ease of use.
### Data Source:
- [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/27/credit+approval)
- [Kaggle](https://www.kaggle.com/datasets/samuelcortinhas/credit-card-approval-clean-data)
### Variable Description:
#### Dependent Variable:
- **Approved**: Whether the application for a credit card is approved, 0=not approved, 1=approved
#### Independent Variables:
- **Gender**: Gender, 0=Female, 1=Male
- **Age**: Age in years
- **Debt**: Outstanding debt (scaled)
- **Married**: Marital status, 0=Single/Divorced/etc, 1=Married
- **BankCustomer**: Bank customer status, 0=does not have a bank account, 1=has a bank account
- **Industry**: Industry - job sector of current or most recent job
- **Ethnicity**: Ethnicity
- **YearsEmployed**: Years employed
- **PriorDefault**: Prior default status, 0=no prior defaults, 1=prior default
- **Employed**: Employment status, 0=not employed, 1=employed
- **CreditScore**: Credit score (scaled)
- **DriversLicense**: Driver's license status, 0=no license, 1=has license
- **Citizen**: Citizenship status, either ByBirth, ByOtherMeans or Temporary
- **ZipCode**: ZipCode (5-digit number)
- **Income**: Income (scaled)
﻿
## Research Method:
### Logistic Regression Model:
Logistic regression is a generalized linear model similar to multiple linear regression but suited for categorical dependent variables. It models the probability of the dependent variable being in a certain category.
### Random Forest Model:
Random Forest is an ensemble learning method that constructs a multitude of decision trees at training time and outputs the class that is the mode of the classes of the individual trees.
﻿
