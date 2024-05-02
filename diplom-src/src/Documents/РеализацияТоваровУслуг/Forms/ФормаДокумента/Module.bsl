#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	//ВКМ_Доработки: Добавить кнопку Заполнить
	ВКМ_ДобавитьКнопкуЗаполнить();
	//Конец ВКМ_Доработки

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
    
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи) 
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)

	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)

	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)

	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	РассчитатьСуммуДокумента();

КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()

	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");

КонецПроцедуры

//ВКМ_Доработки: Добавлена команда Заполнить, проверка на вид договора, вызов процедуры автозаполнения 
&НаСервере
Процедура ВКМ_ДобавитьКнопкуЗаполнить()
	
	КомандаСформироватьТаблицу = Команды.Добавить("Заполнить");
	КомандаСформироватьТаблицу.Действие = "ВКМ_ВыполнитьКомандуЗаполнить";
	КомандаСформироватьТаблицу.Заголовок = "Заполнить";
	КнопкаСформироватьТаблицу = Элементы.Добавить("КнопкаСформироватьТаблицу", Тип("КнопкаФормы"), Элементы.ФормаКоманднаяПанель);
	КнопкаСформироватьТаблицу.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	КнопкаСформироватьТаблицу.ИмяКоманды = "Заполнить";
	
КонецПроцедуры

&НаКлиенте
Процедура ВКМ_ВыполнитьКомандуЗаполнить(Команда)
	
	Если Объект.Услуги.Количество() > 0 Тогда
		ТекстВопроса = НСтр("ru = 'Перед заполнением табличная часть будет очищена. Заполнить?'");
		Оповещение = Новый ОписаниеОповещения("ПослеОтветаНаВопрос", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет,, КодВозвратаДиалога.Да, Заголовок);
	Иначе
		ВКМ_ЗаполнитьДокумент();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтветаНаВопрос(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		Объект.Услуги.Очистить();
		ВКМ_ЗаполнитьДокумент();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ВКМ_ЗаполнитьДокумент()
	
	Если Не ЗначениеЗаполнено(Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить()) Тогда
		ОбщегоНазначения.СообщитьПользователю("Не заполнена константа Номенклатура Работы специалиста.");
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить()) Тогда
		ОбщегоНазначения.СообщитьПользователю("Не заполнена константа Номенклатура Абонентская плата.");
		Возврат;
	КонецЕсли;

	РеквизитыДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.Договор, "ВидДоговора, ВКМ_ДатаНачалаДействия, ВКМ_ДатаОкончанияДействия"); 
	
	Если РеквизитыДоговора.ВидДоговора <> Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание Тогда
		ОбщегоНазначения.СообщитьПользователю("Договор не является договором на абонентское обслуживание. Выберите другой договор.");
		Возврат;
	КонецЕсли;
		
	Если РеквизитыДоговора.ВКМ_ДатаНачалаДействия > Объект.Дата 
		ИЛИ РеквизитыДоговора.ВКМ_ДатаОкончанияДействия < Объект.Дата Тогда
		ОбщегоНазначения.СообщитьПользователю("Дата документа не попадает в период действия договора. Выберите другой договор.");
		Возврат;
	КонецЕсли;
	
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	ДокументОбъект.ВКМ_ВыполнитьАвтозаполнение(ДокументОбъект.Договор);
	ЗначениеВРеквизитФормы(ДокументОбъект,"Объект");
	Модифицированность = Истина;
	
КонецПроцедуры

//Конец ВКМ_Доработки

#Область ПодключаемыеКоманды

 //СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект); 
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения); 
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
