# Create an alert for the 95th % latency for frontend operations
1. Create new alert from panel
    - Change query to include: `operation!~".*Nexus.*"`
2. Reduce
    - Input: C
    - Function: "Last"
    - Mode: Replace with 0
3. Threshold
    - Input: A
    - IS ABOVE 10
4. Pending Period: 1m

With this alert created we can now be alerted when at least 5% of your requests are taking MORE than 10s

NOTE:
- In a production environment, you'll really want to be working in ms and not seconds.
