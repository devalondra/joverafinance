# Removed Stripe-related rules because Stripe is not used anymore

# Keep Apache Commons (if you still use it)
-keep class org.apache.commons.** { *; }
-dontwarn org.apache.commons.**
