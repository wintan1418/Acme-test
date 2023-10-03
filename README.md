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



