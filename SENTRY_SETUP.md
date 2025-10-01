# Sentry Configuration for Art Survey

This document outlines the Sentry configuration for monitoring the Art Survey application in staging and production environments.

## Overview

Sentry is configured to monitor both staging and production environments with comprehensive error tracking, performance monitoring, and logging integration.

## Configuration Details

### Environment Variables Required

Set the following environment variable in your Hatchbox.io environment:

```bash
SENTRY_DSN=https://your-dsn@sentry.io/project-id
```

Optional environment variables:
```bash
SENTRY_RELEASE=your-release-version  # Defaults to git commit hash
```

### Features Enabled

1. **Error Tracking**: All unhandled exceptions are automatically captured
2. **Performance Monitoring**: Transaction tracing with configurable sample rates
3. **Breadcrumbs**: Request context and logging breadcrumbs for better debugging
4. **Custom Context**: Application-specific tags and context
5. **Sensitive Data Filtering**: Automatic removal of passwords, tokens, and sensitive headers
6. **Environment Separation**: Staging and production events are properly tagged

### Sample Rates

- **Production**: 10% of transactions for performance monitoring
- **Staging**: 100% of transactions for comprehensive testing
- **Error Events**: 100% sample rate for all environments

### Excluded Exceptions

The following exceptions are automatically excluded from Sentry reporting:
- `ActionController::RoutingError`
- `ActionController::InvalidAuthenticityToken`
- `ActionDispatch::RemoteIp::IpSpoofAttackError`
- `Mime::Type::InvalidMimeType`

### Security Features

- Sensitive parameters (passwords, tokens) are automatically filtered
- Authorization headers are removed from error reports
- PII (Personally Identifiable Information) is handled according to Sentry's guidelines

## Testing Sentry Integration

A test endpoint is available in staging and production environments:

```
GET /sentry-test
```

This endpoint will:
1. Send a test message to Sentry
2. Generate and capture a test exception
3. Return configuration status

## Monitoring in Sentry Dashboard

### Key Metrics to Monitor

1. **Error Rate**: Track application errors over time
2. **Performance**: Monitor response times and slow queries
3. **Release Tracking**: Monitor errors by deployment version
4. **User Impact**: Track errors affecting real users

### Useful Filters

- Environment: `staging` or `production`
- App: `art_survey`
- Release: Your deployment version

## Configuration Files Modified

1. `config/initializers/sentry.rb` - Main Sentry configuration
2. `config/environments/production.rb` - Production-specific settings (DSN only)
3. `config/environments/staging.rb` - Staging-specific settings (DSN only)
4. `config/routes.rb` - Added test endpoint
5. `app/controllers/static_pages_controller.rb` - Added test method

**Note**: Sentry automatically integrates with Rails' built-in logging system, so no additional logger configuration is needed.

## Best Practices

1. **Monitor Regularly**: Check Sentry dashboard for new errors
2. **Set Up Alerts**: Configure Sentry alerts for critical errors
3. **Track Releases**: Use the release feature to correlate errors with deployments
4. **Review Performance**: Monitor slow transactions and optimize accordingly
5. **Filter Noise**: Adjust excluded exceptions based on your application's needs

## Troubleshooting

### Sentry Not Working

1. Verify `SENTRY_DSN` environment variable is set
2. Check that the DSN is valid and accessible
3. Ensure you're testing in staging or production environment
4. Check Rails logs for Sentry initialization messages

### Too Many Events

1. Adjust sample rates in `config/initializers/sentry.rb`
2. Add more exceptions to the excluded list
3. Review and adjust the `before_send` filter

### Missing Context

1. Verify breadcrumbs are enabled
2. Check that custom context is being set properly
3. Ensure logging integration is working

## Support

For Sentry-specific issues, refer to the [Sentry Ruby documentation](https://docs.sentry.io/platforms/ruby/).
