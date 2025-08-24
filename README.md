# Interactive CFA Question Bank

This repository provides a skeleton for an iOS app that delivers CFA Level I practice questions with instant feedback and optional ChatGPT explanations.

## Structure

- **QuestionBankCore** – Swift package containing question models, a repository for loading questions, a TVM calculator utility, and a ChatGPT API client stub.
- **iOSApp** – Sample SwiftUI interface that lists topics, presents questions, shows explanations, and includes a simple financial calculator.

## Development

```bash
swift test
```

The tests validate core logic such as topic filtering and calculator math.

To experiment with the iOS interface, open the `iOSApp` folder in Xcode on macOS and supply an OpenAI API key via Keychain or the `OPENAI_API_KEY` environment variable.
