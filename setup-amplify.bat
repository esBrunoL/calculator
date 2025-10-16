@echo off
echo 🚀 Flutter Calculator - AWS Amplify Deployment Setup
echo ==================================================
echo.

REM Check if AWS CLI is installed
aws --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ AWS CLI is not installed. Please install it first:
    echo    https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html
    pause
    exit /b 1
)

REM Check if AWS CLI is configured
aws sts get-caller-identity >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ AWS CLI is not configured. Please run 'aws configure' first
    pause
    exit /b 1
)

echo ✅ AWS CLI is installed and configured
echo.

REM Check if Amplify CLI is installed
amplify --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 📦 Installing Amplify CLI...
    npm install -g @aws-amplify/cli
    if %errorlevel% equ 0 (
        echo ✅ Amplify CLI installed successfully
    ) else (
        echo ❌ Failed to install Amplify CLI. Please install manually:
        echo    npm install -g @aws-amplify/cli
        pause
        exit /b 1
    )
) else (
    echo ✅ Amplify CLI is already installed
)

echo.
echo 🎯 Deployment Options:
echo.
echo 1. 🌐 Web Console Deployment (Recommended - Easiest)
echo    - Visit: https://console.aws.amazon.com/amplify/
echo    - Connect GitHub repository: esBrunoL/calculator
echo    - Amplify will auto-detect the amplify.yml configuration
echo    - Click 'Save and Deploy'
echo.
echo 2. 💻 CLI Deployment
echo    - Run: amplify init
echo    - Run: amplify add hosting
echo    - Run: amplify publish
echo.
echo 📋 Your app will be available at:
echo    https://[random-id].amplifyapp.com
echo.
echo 🎉 After deployment, you can:
echo    ✅ Add custom domain
echo    ✅ Set up branch-based deployments
echo    ✅ Enable form handling
echo    ✅ Add user analytics
echo.
echo 📚 For detailed instructions, see: AMPLIFY_DEPLOYMENT.md
echo.

set /p choice="Would you like to initialize Amplify now? (y/n): "
if /i "%choice%"=="y" (
    echo 🚀 Initializing Amplify...
    amplify init
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Amplify initialized successfully!
        echo.
        set /p choice2="Would you like to add hosting now? (y/n): "
        if /i "!choice2!"=="y" (
            amplify add hosting
            
            if %errorlevel% equ 0 (
                echo.
                echo ✅ Hosting configured successfully!
                echo.
                set /p choice3="Would you like to publish the app now? (y/n): "
                if /i "!choice3!"=="y" (
                    flutter build web --release
                    amplify publish
                    
                    if %errorlevel% equ 0 (
                        echo.
                        echo 🎉 Your Flutter Calculator App is now live on AWS Amplify!
                        echo 🌐 Check the output above for your app URL
                    )
                )
            )
        )
    )
) else (
    echo.
    echo ℹ️  You can run 'amplify init' anytime to get started
    echo 📚 See AMPLIFY_DEPLOYMENT.md for detailed instructions
)

echo.
echo 🎯 Deployment complete! Happy calculating! 🧮
pause