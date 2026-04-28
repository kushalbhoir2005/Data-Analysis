use hr;

#Total Employees
SELECT COUNT(*) AS Total_Employees
FROM cleaned_hr_attrition;

#Total Attrition Count
SELECT COUNT(*) AS Total_Attrition
FROM cleaned_hr_attrition
WHERE Attrition = 'Yes';

#Attrition Rate (%)
SELECT 
ROUND(
	(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS Attrition_Rate_Percentage
FROM cleaned_hr_attrition;

#Attrition by Department
SELECT Department, COUNT(*) AS Total_Employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY Department
ORDER BY Attrition_Count DESC;

#Average Salary by Department
SELECT Department, ROUND(AVG(MonthlyIncome), 2) AS Avg_Salary
FROM cleaned_hr_attrition
GROUP BY Department
ORDER BY Avg_Salary DESC;

#Attrition by Salary Range
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low Salary'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS Salary_Category,
    COUNT(*) AS Employee_Count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY Salary_Category;

#Attrition by Job Satisfaction
SELECT JobSatisfaction, COUNT(*) AS Total_Employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

#Attrition by Years at Company
SELECT YearsAtCompany, COUNT(*) AS Total_Employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;

#Gender-wise Attrition
SELECT Gender, COUNT(*) AS Total_Employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY Gender;

#Attrition Based on Overtime
SELECT OverTime, COUNT(*) AS Total_Employees, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY OverTime;

#Top 5 Job Roles with Highest Attrition
SELECT JobRole, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM cleaned_hr_attrition
GROUP BY JobRole
ORDER BY Attrition_Count DESC
LIMIT 5;

#High Risk Employees (Prediction Insight Style)
SELECT *
FROM cleaned_hr_attrition
WHERE 
    JobSatisfaction <= 2
    AND OverTime = 'Yes'
    AND YearsAtCompany < 3;