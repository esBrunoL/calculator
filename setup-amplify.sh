#!/bin/bash

# AWS Amplify Setup Script for Flutter Calculator App
# This script helps you deploy your Flutter app to AWS Amplify

echo "🚀 Flutter Calculator - AWS Amplify Deployment Setup"
echo "=================================================="
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first:"
    echo "   https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html"
    exit 1
fi

# Check if AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS CLI is not configured. Please run 'aws configure' first"
    exit 1
fi

echo "✅ AWS CLI is installed and configured"
echo ""

# Check if Amplify CLI is installed
if ! command -v amplify &> /dev/null; then
    echo "📦 Installing Amplify CLI..."
    npm install -g @aws-amplify/cli
    if [ $? -eq 0 ]; then
        echo "✅ Amplify CLI installed successfully"
    else
        echo "❌ Failed to install Amplify CLI. Please install manually:"
        echo "   npm install -g @aws-amplify/cli"
        exit 1
    fi
else
    echo "✅ Amplify CLI is already installed"
fi

echo ""
echo "🎯 Deployment Options:"
echo ""
echo "1. 🌐 Web Console Deployment (Recommended - Easiest)"
echo "   - Visit: https://console.aws.amazon.com/amplify/"
echo "   - Connect GitHub repository: esBrunoL/calculator"
echo "   - Amplify will auto-detect the amplify.yml configuration"
echo "   - Click 'Save and Deploy'"
echo ""
echo "2. 💻 CLI Deployment"
echo "   - Run: amplify init"
echo "   - Run: amplify add hosting"
echo "   - Run: amplify publish"
echo ""
echo "📋 Your app will be available at:"
echo "   https://[random-id].amplifyapp.com"
echo ""
echo "🎉 After deployment, you can:"
echo "   ✅ Add custom domain"
echo "   ✅ Set up branch-based deployments"
echo "   ✅ Enable form handling"
echo "   ✅ Add user analytics"
echo ""
echo "📚 For detailed instructions, see: AMPLIFY_DEPLOYMENT.md"
echo ""

read -p "Would you like to initialize Amplify now? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Initializing Amplify..."
    amplify init
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Amplify initialized successfully!"
        echo ""
        read -p "Would you like to add hosting now? (y/n): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            amplify add hosting
            
            if [ $? -eq 0 ]; then
                echo ""
                echo "✅ Hosting configured successfully!"
                echo ""
                read -p "Would you like to publish the app now? (y/n): " -n 1 -r
                echo ""
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    flutter build web --release
                    amplify publish
                    
                    if [ $? -eq 0 ]; then
                        echo ""
                        echo "🎉 Your Flutter Calculator App is now live on AWS Amplify!"
                        echo "🌐 Check the output above for your app URL"
                    fi
                fi
            fi
        fi
    fi
else
    echo ""
    echo "ℹ️  You can run 'amplify init' anytime to get started"
    echo "📚 See AMPLIFY_DEPLOYMENT.md for detailed instructions"
fi

echo ""
echo "🎯 Deployment complete! Happy calculating! 🧮"