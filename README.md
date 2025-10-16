# Calculator App

A professional Flutter calculator application designed for AWS deployment with state persistence and modern UI.

## Features

- **8-digit display** with overflow and error handling
- **Standard calculator operations**: Addition, Subtraction, Multiplication, Division
- **Intuitive layout**: 3x3 number grid (1-9), clear buttons (CE/C), and operation buttons
- **State persistence**: Remembers the last value between app sessions
- **Error handling**: Displays ERROR for division by zero, OVERFLOW for large numbers
- **Modern UI**: Professional styling with responsive design
- **AWS Ready**: Configured for containerized deployment on AWS ECS

## Technical Specifications

### Display
- Up to 8 digits with automatic overflow protection
- Error states: `ERROR`, `OVERFLOW`
- Automatic font scaling for long numbers

### Button Layout
```
| CE | C  | /  | *  |
| 7  | 8  | 9  | -  |
| 4  | 5  | 6  | +  |
| 1  | 2  | 3  | =  |
| 0     | .  |    |   |
```

### State Management
- Uses SharedPreferences for local storage
- Saves display value automatically after each operation
- Restores last value on app restart
- Does not persist operations between sessions

## Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Docker (for AWS deployment)
- AWS CLI (for deployment)

### Local Development

1. **Clone the repository:**
   ```bash
   git clone <your-repository-url>
   cd calculatorApp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Web Development

1. **Enable web support:**
   ```bash
   flutter config --enable-web
   ```

2. **Run on web:**
   ```bash
   flutter run -d chrome
   ```

3. **Build for web:**
   ```bash
   flutter build web --release
   ```

## AWS Deployment

This application supports two AWS deployment options:

### 🚀 **Recommended: AWS Amplify** (Simplest)
- **One-click deployment** from GitHub
- **Automatic CI/CD** with global CDN
- **HTTPS by default** with custom domains
- **Cost-effective** and maintenance-free

See `AMPLIFY_DEPLOYMENT.md` for complete Amplify setup guide.

### ⚙️ **Alternative: ECS Fargate** (Advanced)
- **ECS Fargate** for container orchestration  
- **Application Load Balancer** for load distribution
- **ECR** for container registry
- **CodeBuild** for CI/CD pipeline

See `DEPLOYMENT.md` for complete ECS setup guide.

### Deployment Steps

1. **Set up AWS infrastructure:**
   ```bash
   aws cloudformation create-stack \
     --stack-name calculator-app-infrastructure \
     --template-body file://cloudformation-template.json \
     --parameters ParameterKey=AppName,ParameterValue=calculator-app
   ```

2. **Build and push Docker image:**
   ```bash
   # Build the Flutter web app
   flutter build web --release
   
   # Build Docker image
   docker build -t calculator-app .
   
   # Tag and push to ECR
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
   docker tag calculator-app:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/calculator-app:latest
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/calculator-app:latest
   ```

3. **Deploy using CodeBuild:**
   - Connect your GitHub repository to AWS CodeBuild
   - Use the provided `buildspec.yml` for automated builds
   - Set up environment variables for your AWS account

### Environment Variables for AWS CodeBuild

- `AWS_DEFAULT_REGION`: Your AWS region
- `AWS_ACCOUNT_ID`: Your AWS account ID
- `IMAGE_REPO_NAME`: calculator-app

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── calculator_model.dart    # Calculator logic and state
├── services/
│   └── storage_service.dart     # SharedPreferences wrapper
└── widgets/
    ├── calculator_screen.dart   # Main calculator UI
    └── calculator_button.dart   # Custom button widget
```

## Architecture

### Calculator Model
- Handles all calculation logic
- Manages display state and error conditions
- Supports chained operations
- Validates input and output ranges

### Storage Service
- Abstracts SharedPreferences operations
- Persists calculator display value
- Handles storage errors gracefully

### UI Components
- **CalculatorScreen**: Main interface with display and button grid
- **CalculatorButton**: Reusable button component with consistent styling
- Responsive design that works on multiple screen sizes

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository.