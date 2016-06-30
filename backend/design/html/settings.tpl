{capture name=tabs}
    <li class="active"><a href="index.php?module=SettingsAdmin">Настройки</a></li>
    {if in_array('currency', $manager->permissions)}
        <li><a href="index.php?module=CurrencyAdmin">Валюты</a></li>
    {/if}
    {if in_array('delivery', $manager->permissions)}
        <li><a href="index.php?module=DeliveriesAdmin">Доставка</a></li>
    {/if}
    {if in_array('payment', $manager->permissions)}
        <li><a href="index.php?module=PaymentMethodsAdmin">Оплата</a></li>
    {/if}
    {if in_array('managers', $manager->permissions)}
        <li><a href="index.php?module=ManagersAdmin">Менеджеры</a></li>
    {/if}
    {if in_array('languages', $manager->permissions)}
        <li><a href="index.php?module=LanguagesAdmin">Языки</a></li>
    {/if}
    {if in_array('languages', $manager->permissions)}
        <li><a href="index.php?module=TranslationsAdmin">Переводы</a></li>
    {/if}
{/capture}
 
{$meta_title = "Настройки" scope=parent}

{if $message_success}
<div class="message message_success">
	<span class="text">{if $message_success == 'saved'}Настройки сохранены{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
{/if}

{if $message_error}
<div class="message message_error">
	<span class="text">{if $message_error == 'watermark_is_not_writable'}Установите права на запись для файла {$config->watermark_file}{/if}</span>
	<a class="button" href="">Вернуться</a>
</div>
{/if}

<h2 style="text-align: center">OkayCMS Lite</h2>
<form method=post id=product enctype="multipart/form-data">
    <input type=hidden name="session_id" value="{$smarty.session.id}">
    <div class="block">
        <h2>Настройки сайта</h2>
        <ul>
            <li><label class=property>Имя сайта</label><input name="site_name" class="okay_inp" type="text" value="{$settings->site_name|escape}" /></li>
            <li><label class=property>Имя компании</label><input name="company_name" class="okay_inp" type="text" value="{$settings->company_name|escape}" /></li>
            <li><label class=property>Формат даты</label><input name="date_format" class="okay_inp" type="text" value="{$settings->date_format|escape}" /></li>
            <li><label class=property>Email для восстановления пароля</label><input name="admin_email" class="okay_inp" type="text" value="{$settings->admin_email|escape}" /></li>
        </ul>
    </div>
    <div class="block layer">
        <h2>Оповещения</h2>
        <ul>
            <li><label class=property>Оповещение о заказах</label><input name="order_email" class="okay_inp" type="text" value="{$settings->order_email|escape}" /></li>
            <li><label class=property>Оповещение о комментариях</label><input name="comment_email" class="okay_inp" type="text" value="{$settings->comment_email|escape}" /></li>
            <li><label class=property>Обратный адрес оповещений</label><input name="notify_from_email" class="okay_inp" type="text" value="{$settings->notify_from_email|escape}" /></li>
            <li><label class=property>Имя отправителя письма</label><input name="notify_from_name" class="okay_inp" type="text" value="{$settings->notify_from_name|escape}" /></li>

        </ul>
    </div>
    <div class="block layer">
        <h2>Капча вкл./выкл.</h2>
        <ul>
            <li><label class=property for="captcha_product">В товаре</label><input id="captcha_product" name="captcha_product" class="okay_inp" type="checkbox" value="1" {if $settings->captcha_product}checked=""{/if} /></li>
            <li><label class=property for="captcha_post">В статье блога</label><input id="captcha_post" name="captcha_post" class="okay_inp" type="checkbox" value="1" {if $settings->captcha_post}checked=""{/if} /></li>
            <li><label class=property for="captcha_cart">В корзине</label><input id="captcha_cart" name="captcha_cart" class="okay_inp" type="checkbox" value="1" {if $settings->captcha_cart}checked=""{/if} /></li>
            <li><label class=property for="captcha_register">В форме регистрации</label><input id="captcha_register" name="captcha_register" class="okay_inp" type="checkbox" value="1" {if $settings->captcha_register}checked=""{/if} /></li>
            <li><label class=property for="captcha_feedback">В форме обратной связи</label><input id="captcha_feedback" name="captcha_feedback" class="okay_inp" type="checkbox" value="1" {if $settings->captcha_feedback}checked=""{/if} /></li>
        </ul>
    </div>

    <div class="block layer">
        <h2>Формат цены</h2>
        <ul>
            <li><label class=property>Разделитель копеек</label>
                <select name="decimals_point" class="okay_inp">
                    <option value='.' {if $settings->decimals_point == '.'}selected{/if}>точка: 12.45 {$currency->sign|escape}</option>
                    <option value=',' {if $settings->decimals_point == ','}selected{/if}>запятая: 12,45 {$currency->sign|escape}</option>
                </select>
            </li>
            <li><label class=property>Разделитель тысяч</label>
                <select name="thousands_separator" class="okay_inp">
                    <option value='' {if $settings->thousands_separator == ''}selected{/if}>без разделителя: 1245678 {$currency->sign|escape}</option>
                    <option value=' ' {if $settings->thousands_separator == ' '}selected{/if}>пробел: 1 245 678 {$currency->sign|escape}</option>
                    <option value=',' {if $settings->thousands_separator == ','}selected{/if}>запятая: 1,245,678 {$currency->sign|escape}</option>
                </select>
            </li>
        </ul>
    </div>

    <div class="block layer">
        <h2>Настройки каталога</h2>
        <ul>
            <li><label class=property>Товаров на странице сайта</label><input name="products_num" class="okay_inp" type="text" value="{$settings->products_num|escape}" /></li>
            <li><label class=property>Максимум товаров в заказе</label><input name="max_order_amount" class="okay_inp" type="text" value="{$settings->max_order_amount|escape}" /></li>
            <li><label class=property>Единицы измерения товаров</label><input name="units" class="okay_inp" type="text" value="{$settings->units|escape}" /></li>
            <li><label class="property">Максимальное количество товаров в папке сравнения</label><input name="comparison_count" class="okay_inp" type="text" value="{$settings->comparison_count|escape}" /></li>
            <li><label class="property">Статей на странице блога</label><input name="posts_num" class="okay_inp" type="text" value="{$settings->posts_num|escape}" /></li>
            <li>
                <label class="property">Если нет в наличии
                    <div class="helper_wrap">
                        <a href="javascript:;" id="show_help_search" class="helper_link"></a>
                        <div class="right helper_block">
                        <span>
                            Выберите что происходит с товарами которых нет на складе.
                            Или они доступны под заказ, или отображаются что их нет в наличии
                        </span>
                        </div>
                    </div>
                </label>
            </li>
        </ul>
    </div>

    <div class="block layer">
        <h2>Настройки 1C</h2>
        <ul>
            <li><label class=property>Логин</label><input name="login_1c" class="okay_inp" type="text" value="{$login_1c|escape}" /></li>
            <li><label class=property>Пароль</label><input name="pass_1c" class="okay_inp" type="text" value="" /></li>
        </ul>
    </div>

    <div class="block layer">
        <h2>Изображения товаров</h2>
        <ul>
            <li><label class=property>Водяной знак</label>
            <input name="watermark_file" class="okay_inp" type="file" />

            <img style='display:block; border:1px solid #d0d0d0; margin:10px 0 10px 0;' src="{$config->root_url}/{$config->watermark_file}?{math equation='rand(10,10000)'}">
            </li>
            <li><label class=property>Горизонтальное положение водяного знака</label><input name="watermark_offset_x" class="okay_inp" type="text" value="{$settings->watermark_offset_x|escape}" /> %</li>
            <li><label class=property>Вертикальное положение водяного знака</label><input name="watermark_offset_y" class="okay_inp" type="text" value="{$settings->watermark_offset_y|escape}" /> %</li>
            <li><label class=property>Прозрачность знака (больше &mdash; прозрачней)</label><input name="watermark_transparency" class="okay_inp" type="text" value="{$settings->watermark_transparency|escape}" /> %</li>
            <li><label class=property>Резкость изображений (рекомендуется 20%)</label><input name="images_sharpen" class="okay_inp" type="text" value="{$settings->images_sharpen|escape}" /> %</li>
        </ul>
    </div>

    <input class="button_green button_save" type="submit" name="save" value="Сохранить" />
</form>
