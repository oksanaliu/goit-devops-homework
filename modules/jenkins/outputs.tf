output "jenkins_url" {
  value = "Зачекай пару хвилин і виконай: kubectl get svc -n jenkins"
}

output "jenkins_admin_password_command" {
  value = "Отримати пароль: kubectl get secret --namespace jenkins jenkins -o jsonpath='{.data.jenkins-admin-password}' | base64 --decode; echo"
}
