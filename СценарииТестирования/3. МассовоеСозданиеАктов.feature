﻿#language: ru

@tree

Функционал: Массовое создание актов

Как Бухгалтер
Я хочу массово создать акты за апрель месяц 2024 года
Чтобы отправить их клиентам и получить оплаты по выполненным работам 

Контекст: Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	
Сценарий: Массовое создание актов
	Тогда я подключаю TestClient "ТестКлиент" логин "Бухгалтер" пароль ""
	И В командном интерфейсе я выбираю 'Добавленные объекты' 'Массовое создание актов'
	Тогда открылось окно 'Обработка для массового создания актов'
	И я нажимаю кнопку выбора у поля с именем "Период"
	Тогда открылось окно 'Выберите период'
	И я нажимаю кнопку выбора у поля с именем "DateBegin"
	И в поле с именем 'DateBegin' я ввожу текст '01.04.2024'
	И я нажимаю кнопку выбора у поля с именем "DateEnd"
	И в поле с именем 'DateEnd' я ввожу текст '30.04.2024'
	И я нажимаю на кнопку 'Выбрать'
	Тогда открылось окно 'Обработка для массового создания актов'
	И я нажимаю на кнопку 'Создать документы'
	Тогда открылось окно 'Обработка для массового создания актов'
	