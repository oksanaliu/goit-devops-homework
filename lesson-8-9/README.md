# Homework: Lesson 8-9 (Jenkins + Helm + Terraform + Argo CD)

Цей проєкт реалізує повний автоматизований цикл CI/CD для Django-застосунку з розгортанням в Amazon EKS кластері.

## Архітектура CI/CD

1. **Infrastructure as Code (IaC):** Весь стек (VPC, EKS, ECR, Jenkins, Argo CD) розгортається через **Terraform**.
2. **CI Pipeline (Jenkins):** Jenkins використовує Kubernetes Agents (Kaniko) для збірки Docker-образу, пушить його в **Amazon ECR** та автоматично оновлює тег версії у Helm-чарті в GitHub.
3. **CD (Argo CD):** Відстежує зміни в репозиторії та автоматично синхронізує стан кластера з Helm-чартом.

## Як запустити проєкт

### Крок 1: Створення інфраструктури (Terraform)

Розгортання мережі (VPC), ECR (реєстр для Docker образів) та EKS кластеру.

```bash
cd lesson-7

terraform init
terraform apply -auto-approve
```

### Крок 2: Налаштування доступу до Kubernetes:

```bash
aws eks update-kubeconfig --region eu-west-1 --name lesson-8-9-cluster
```

### Крок 3: Доступ до Argo CD:

```bash
kubectl port-forward svc/argo-cd-argocd-server -n argocd 8081:443
```

Логін: admin, пароль можна отримати через Secret argocd-initial-admin-secret.

### Перевірка статусів подів

```bash
kubectl get pods -n default
```

### Очищення

```bash
terraform destroy -auto-approve
```

## Результати роботи (Screenshots)

### Jenkins: Всі етапи Pipeline (Build, Push, Update Git) проходять успішно (Build #11).

![Deployment Success](./screenshots/hw1.png)

### Робота GitOps-пайплайну в Argo CD, що підтверджується статусом Synced для гілки lesson-8-9, автоматичним розгортанням образу та переходом пода у стан Healthy після успішного запуску контейнера

![Deployment Success](./screenshots/hw3.png)

### Історію подій в Argo CD, яка підтверджує успішну синхронізацію проєкту, автоматичне оновлення статусів із Git та працездатність GitOps-пайплайну в режимі реального часу.

![Deployment Success](./screenshots/hw5.png)

### Загальна архітектура застосунку в Argo CD: статус Synced підтверджує успішну автоматичну синхронізацію з Git-репозиторієм, а дерево ресурсів демонструє повне розгортання всіх необхідних компонентів (ConfigMap, Secret, Service, Pods) за допомогою Helm-чарта

![Deployment Success](./screenshots/hw4.png)

### Статус Degraded для об'єкта HPA є очікуваним через відсутність Metrics Server у навчальному кластері та не впливає на стабільну роботу самого застосунку.

## Cхема CI/CD

1. **Push коду в GitHub (гілка lesson-8-9).**
2. **Jenkins Pipeline запускається через Kubernetes Agent.**
3. **Kaniko збирає Docker-образ Django.**
4. **Jenkins пушить образ в Amazon ECR з тегом збірки (наприклад, :7).**
5. **Jenkins оновлює values.yaml у GitHub, змінюючи тег на новий.**
6. **Argo CD бачить зміни в Git і автоматично розгортає нову версію в EKS.**
