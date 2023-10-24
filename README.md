									Цикл по развертыванию инфраструктуры.
необходимые инструменты:
1)Действующий аккаунд в яндекс облаке
2)Установленный Terraform
# sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
# wget -O- https://apt.releases.hashicorp.com/gpg | \gpg --dearmor | \sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# wget -O- https://apt.releases.hashicorp.com/gpg | \gpg --dearmor | \sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# sudo apt update && sudo apt-get install terraform
3) Установленный ansible и python3
# sudo apt-get install python3 ansible ansible-core

Описание процесса:
В репозитории представлены 2 варанта: с одним сервером (каталог OneServer) и с двумя (каталог TwoServers). При использовании
любого из вариантов сперва требуется внести данные в файл terraform.tfvars - "cloud_id, token, folder_id
1)Создаем пару ключей - команда ssh keygen
2)main.tf лежит в папках TerraformOneServer и TerraformTwoServers. Следовательно запуск командой terraform init должен осуществляться при
нахождении в любой из этих папок. Перед запуском команды желательно вывести значения всех переменных такие как cloud_id, folder_id, token в отдельный
файл с расширение tfvars (example.tfvars)
3)Разворот инфраструктуры в облако - команда terraform apply
4)Разворот react приложения на сервер при помощи ansible. Применяем ansible-playbook -b reactjs.yaml -vv

После применения плейбука, приложение станет доступным в браузере по внешнему IP сервера
