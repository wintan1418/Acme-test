#1: Improve API Response Time
Problem: The User#count_hits method takes approximately 500ms to run and is being called 50 times per second, leading to timeouts.

Solution:

I Implemented a counter cache for hits. This involves adding a hits_count column to the users table, which automatically keeps track of the number of hits a user has. This eliminates the need for expensive queries.

#2: "Over Quota" Errors for Australian Users
Problem: Australian users are seeing "over quota" errors at the start of a new month due to timezone discrepancies.

Root Cause: The API resets quotas based on UTC time, while users in Australia are ahead of UTC.

#3: Exceeding Monthly API Request Limit
Problem: Some users are making more requests than their monthly limit.

Possible Cause:

Race conditions allowing users to make simultaneous requests that get processed before the quota is updated.
Cached data not reflecting the most recent hit count.
Solution:

I have Implemented an optimistic locking or database-level constraints to ensure accurate hit counting.
Ensuring cache data is up-to-date.
Time Zone Storage: I added a time_zone column to our User model. This allows us to store each user's specific time zone.

Time Zone Detection with Geocoder: Upon integrating the geocoder gem, I implemented functionality to automatically detect a user's time zone based on their IP address when they sign up or log in. This aids in giving users a more personalized experience, and it ensures accurate quota resets according to their local time.

Devise Controllers Customization: I generated and customized Devise controllers for our User model. The reason behind this was to seamlessly integrate the time zone detection into our sign-up and login processes. Now, whenever a user signs up or logs in, their time zone is automatically updated (if detectable from their IP).

Updating Hit Counts: With the user's time zone data available, I modified the method that counts a user's API hits. Now, the count and quota reset is relative to the beginning of the month in the user's specific time zone, ensuring fairness for all users globally.

#3: Exceeding Monthly API Request Limit
Problem: Some users are making more requests than their monthly limit.

Possible Cause:

Race conditions allowing users to make simultaneous requests that get processed before the quota is updated.
Cached data not reflecting the most recent hit count.
Solution:

Implement optimistic locking or database-level constraints to ensure accurate hit counting.
Ensure cache data is up-to-date or consider a more real-time data solution.

#4: Code Refactoring for Better Maintainability
Problem: The existing codebase has accumulated technical debt, making it challenging to maintain.

Solution:

I have used modern Rails conventions: Replaced deprecated methods like before_filter with before_action.
Modularized code: Break down complex methods into smaller, reusable parts.
Add comments: Wherever complex logic exists, describe its purpose and functionality.



