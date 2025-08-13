pipeline {
  agent any

  environment {
    APP_NAME = 'hello-ci'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    // Для локального реестра используем localhost:5001 (см. раздел 4)
    REGISTRY = 'localhost:5001'
    IMAGE = "${REGISTRY}/${APP_NAME}:${IMAGE_TAG}"
    IMAGE_LATEST = "${REGISTRY}/${APP_NAME}:latest"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build image') {
      steps {
        sh 'docker version'        // проверим доступ к Docker
        sh "docker build -t ${IMAGE} ."
      }
    }

    stage('Unit tests (pytest)') {
      steps {
        // Запускаем тесты внутри образа
        sh "docker run --rm ${IMAGE} pytest -q"
      }
    }

    stage('Tag & Push') {
      when { branch 'main' } // пушим только с ветки main
      steps {
        sh "docker tag ${IMAGE} ${IMAGE_LATEST}"
        sh "docker push ${IMAGE}"
        sh "docker push ${IMAGE_LATEST}"
      }
    }
  }

  post {
    always {
      sh "docker images | head -n 5 || true"
    }
  }
}
