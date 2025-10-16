# AWS Amplify Deployment Guide

AWS Amplify provides the simplest way to deploy your Flutter calculator app with automatic CI/CD, global distribution, and HTTPS.

## Quick Deployment Steps

### 1. Deploy to Amplify (Web Console)

1. **Go to AWS Amplify Console:**
   - Visit https://console.aws.amazon.com/amplify/
   - Click "Get Started" under "Deploy"

2. **Connect GitHub Repository:**
   - Select "GitHub" as source
   - Connect your account if needed
   - Choose repository: `esBrunoL/calculator`
   - Select branch: `main`

3. **Configure Build Settings:**
   - Amplify will auto-detect `amplify.yml`
   - Review the build settings (they should be automatically populated)
   - Click "Next"

4. **Review and Deploy:**
   - Review all settings
   - Click "Save and Deploy"
   - Wait for deployment to complete (~5-10 minutes)

### 2. Deploy via AWS CLI (Alternative)

```bash
# Install Amplify CLI
npm install -g @aws-amplify/cli

# Configure Amplify
amplify configure

# Initialize Amplify in your project
cd "c:\Users\bruno\Documents\mobileApp\calculatorApp"
amplify init

# Add hosting
amplify add hosting
# Choose: Amazon CloudFront and S3
# Choose: DEV (S3 only with HTTP)

# Publish
amplify publish
```

## Configuration Details

### Build Process
The `amplify.yml` file configures:
- **Flutter Installation**: Downloads and sets up Flutter SDK
- **Dependencies**: Runs `flutter pub get`
- **Web Build**: Executes `flutter build web --release`
- **Output**: Serves files from `build/web` directory

### Automatic Features
- ✅ **CI/CD**: Automatically builds and deploys on every push to main
- ✅ **HTTPS**: SSL certificate automatically provisioned
- ✅ **CDN**: Global distribution via CloudFront
- ✅ **Custom Domain**: Easy to add your own domain
- ✅ **Preview Deployments**: Automatic preview for pull requests

## Environment Variables (Optional)

If you need environment-specific configurations:

1. **In Amplify Console:**
   - Go to App Settings > Environment Variables
   - Add variables like:
     - `FLUTTER_WEB_USE_SKIA=false`
     - `FLUTTER_WEB_AUTO_DETECT=true`

## Custom Domain Setup

1. **In Amplify Console:**
   - Go to App Settings > Domain Management
   - Click "Add Domain"
   - Enter your domain name
   - Follow DNS configuration steps

## Monitoring and Logs

- **Build Logs**: Available in Amplify Console during deployment
- **Access Logs**: CloudFront access logs can be enabled
- **Performance**: Built-in performance monitoring

## Advantages of Amplify vs ECS

| Feature | Amplify | ECS/Fargate |
|---------|---------|-------------|
| Setup Complexity | ⭐ Simple | ⭐⭐⭐ Complex |
| CI/CD | ✅ Built-in | ⚙️ Manual setup |
| HTTPS | ✅ Automatic | ⚙️ Manual setup |
| Global CDN | ✅ Built-in | ⚙️ Additional config |
| Cost | 💰 Lower | 💰💰 Higher |
| Maintenance | ⭐ Minimal | ⭐⭐⭐ High |

## Costs

**Amplify Pricing:**
- Build minutes: $0.01 per minute
- Data transfer: $0.15 per GB
- Requests: $0.30 per million requests
- Storage: $0.023 per GB per month

**Typical monthly cost for a calculator app: $1-5**

## Troubleshooting

### Common Issues:

1. **Build Fails:**
   ```bash
   # Check Flutter version in build logs
   # Ensure amplify.yml has correct Flutter channel
   ```

2. **App Doesn't Load:**
   ```bash
   # Check browser console for errors
   # Verify web/index.html is properly configured
   ```

3. **Slow Loading:**
   ```bash
   # Enable compression in amplify.yml
   # Use --web-renderer html for better compatibility
   ```

## Next Steps After Deployment

1. **Custom Domain**: Add your own domain name
2. **Analytics**: Enable user analytics
3. **Forms**: Add contact forms if needed
4. **Authentication**: Add user login if required
5. **API**: Connect to backend APIs if needed

## Branch-based Deployments

Amplify automatically creates deployments for:
- **Main branch**: Production environment
- **Feature branches**: Preview environments
- **Pull requests**: Automatic preview links

This setup provides a professional, scalable deployment with minimal configuration!