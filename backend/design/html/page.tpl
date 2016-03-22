{capture name=tabs}
	{if in_array('pages', $manager->permissions)}
	{foreach $menus  as $m}
		<li {if $m->id == $menu->id}class="active"{/if}><a href='index.php?module=PagesAdmin&menu_id={$m->id}'>{$m->name}</a></li>
	{/foreach}
	{/if}
{/capture}

{if $page->id}
{$meta_title = $page->name scope=parent}
{else}
{$meta_title = 'Новая страница' scope=parent}
{/if}

{* Подключаем Tiny MCE *}
{include file='tinymce_init.tpl'}
{* On document load *}
{literal}
<script>
    $(window).on("load", function() {

	// Автозаполнение мета-тегов
	menu_item_name_touched = true;
	meta_title_touched = true;
	meta_keywords_touched = true;
	meta_description_touched = true;
	
	if($('input[name="menu_item_name"]').val() == generate_menu_item_name() || $('input[name="name"]').val() == '')
		menu_item_name_touched = false;
	if($('input[name="meta_title"]').val() == generate_meta_title() || $('input[name="meta_title"]').val() == '')
		meta_title_touched = false;
	if($('input[name="meta_keywords"]').val() == generate_meta_keywords() || $('input[name="meta_keywords"]').val() == '')
		meta_keywords_touched = false;
	if($('textarea[name="meta_description"]').val() == generate_meta_description() || $('textarea[name="meta_description"]').val() == '')
		meta_description_touched = false;
		
	$('input[name="name"]').change(function() { menu_item_name_touched = true; });
	$('input[name="meta_title"]').change(function() { meta_title_touched = true; });
	$('input[name="meta_keywords"]').change(function() { meta_keywords_touched = true; });
	$('textarea[name="meta_description"]').change(function() { meta_description_touched = true; });
	
	$('input[name="header"]').keyup(function() { set_meta(); });
});

function set_meta()
{
	if(!menu_item_name_touched)
		$('input[name="name"]').val(generate_menu_item_name());
	if(!meta_title_touched)
		$('input[name="meta_title"]').val(generate_meta_title());
	if(!meta_keywords_touched)
		$('input[name="meta_keywords"]').val(generate_meta_keywords());
    if(!meta_description_touched)
    {
        descr = $('textarea[name="meta_description"]');
        descr.val(generate_meta_description());
        descr.scrollTop(descr.outerHeight());
    }
	if(!$('#block_translit').is(':checked'))
		$('input[name="url"]').val(generate_url());
}

function generate_menu_item_name()
{
	name = $('input[name="header"]').val();
	return name;
}

function generate_meta_title()
{
	name = $('input[name="header"]').val();
	return name;
}

function generate_meta_keywords()
{
	name = $('input[name="header"]').val();
	return name;
}

function generate_meta_description()
{
    if(typeof(tinyMCE.get("body")) =='object')
    {
        description = tinyMCE.get("body").getContent().replace(/(<([^>]+)>)/ig," ").replace(/(\&nbsp;)/ig," ").replace(/^\s+|\s+$/g, '').substr(0, 512);
        return description;
    }
    else
        return $('textarea[name=body]').val().replace(/(<([^>]+)>)/ig," ").replace(/(\&nbsp;)/ig," ").replace(/^\s+|\s+$/g, '').substr(0, 512);
}

function generate_url()
{
	url = $('input[name="header"]').val();
	url = url.replace(/[\s]+/gi, '-');
	url = translit(url);
	url = url.replace(/[^0-9a-z_\-]+/gi, '').toLowerCase();	
	return url;
}

function translit(str)
{
	var ru=("А-а-Б-б-В-в-Ґ-ґ-Г-г-Д-д-Е-е-Ё-ё-Є-є-Ж-ж-З-з-И-и-І-і-Ї-ї-Й-й-К-к-Л-л-М-м-Н-н-О-о-П-п-Р-р-С-с-Т-т-У-у-Ф-ф-Х-х-Ц-ц-Ч-ч-Ш-ш-Щ-щ-Ъ-ъ-Ы-ы-Ь-ь-Э-э-Ю-ю-Я-я").split("-")   
	var en=("A-a-B-b-V-v-G-g-G-g-D-d-E-e-E-e-E-e-ZH-zh-Z-z-I-i-I-i-I-i-J-j-K-k-L-l-M-m-N-n-O-o-P-p-R-r-S-s-T-t-U-u-F-f-H-h-TS-ts-CH-ch-SH-sh-SCH-sch-'-'-Y-y-'-'-E-e-YU-yu-YA-ya").split("-")   
 	var res = '';
	for(var i=0, l=str.length; i<l; i++)
	{ 
		var s = str.charAt(i), n = ru.indexOf(s); 
		if(n >= 0) { res += en[n]; } 
		else { res += s; } 
    } 
    return res;  
}


</script>


{/literal}

{if $languages}{include file='include_languages.tpl'}{/if}

{if $message_success}
<!-- Системное сообщение -->
<div class="message message_success">
	<span class="text">{if $message_success == 'added'}Страница добавлена{elseif $message_success == 'updated'}Страница обновлена{/if}</span>
	<a class="link" target="_blank" href="../{$lang_link}{$page->url}">Открыть страницу на сайте</a>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
	
	<span class="share">		
		<a href="#" onClick='window.open("http://vkontakte.ru/share.php?url={$config->root_url|urlencode}/{$page->url|urlencode}&title={$page->name|urlencode}&description={$page->body|urlencode}&noparse=false","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
  		<img src="{$config->root_url}/backend/design/images/vk_icon.png" /></a>
		<a href="#" onClick='window.open("http://www.facebook.com/sharer.php?u={$config->root_url|urlencode}/{$page->url|urlencode}","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
  		<img src="{$config->root_url}/backend/design/images/facebook_icon.png" /></a>
		<a href="#" onClick='window.open("http://twitter.com/share?text={$page->name|urlencode}&url={$config->root_url|urlencode}/{$page->url|urlencode}&hashtags={$page->meta_keywords|replace:' ':''|urlencode}","displayWindow","width=700,height=400,left=250,top=170,status=no,toolbar=no,menubar=no");return false;'>
  		<img src="{$config->root_url}/backend/design/images/twitter_icon.png" /></a>
	</span>
	
</div>
<!-- Системное сообщение (The End)-->
{/if}

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span class="text">{if $message_error == 'url_exists'}Страница с таким адресом уже существует{elseif $message_error=='empty_header'}Введите заголовок{elseif $message_error == 'url_wrong'}Адрес не должен начинаться или заканчиваться символом '-'{else}{$message_error}{/if}</span>
	<a class="button" href="">Вернуться</a>
</div>
<!-- Системное сообщение (The End)-->
{/if}



<!-- Основная форма -->
<form method=post id=product enctype="multipart/form-data">
	<input type=hidden name="session_id" value="{$smarty.session.id}">
    <input type="hidden" name="lang_id" value="{$lang_id}" />
	<div id="name">
		<input class="name" name=header type="text" value="{$page->header|escape}"/> 
		<input name=id type="hidden" value="{$page->id|escape}"/> 
		<div class="checkbox">
			<input name=visible value='1' type="checkbox" id="active_checkbox" {if $page->visible}checked{/if}/> <label for="active_checkbox" class="visible_icon">Активна</label>
		</div>
	</div> 

		<!-- Параметры страницы -->
		<div class="block">
			<ul>
				<li><label class=property>Название пункта в меню</label><input name="name" class="okay_inp" type="text" value="{$page->name|escape}" /></li>
				<li><label class=property>Меню</label>	
					<select name="menu_id">
				   		{foreach $menus as $m}
				        	<option value='{$m->id}' {if $page->menu_id == $m->id}selected{/if}>{$m->name|escape}</option>
				    	{/foreach}
					</select>		
				</li>
			</ul>
		</div>
		<!-- Параметры страницы (The End)-->

	<!-- Левая колонка свойств товара -->
	<div id="column_left">
			
		<!-- Параметры страницы -->
		<div class="block layer">
			<h2>Параметры страницы</h2>
			<ul>
                <li><label class="property" for="block_translit">Заблокировать авто генерацию ссылки</label>
                    <input type="checkbox" id="block_translit" {if $page->id}checked=""{/if} />
                    <div class="helper_wrap">
                        <a href="javascript:;" id="show_help_search" class="helper_link"></a>
                        <div class="right helper_block">
                            <b>Запрещает изменение URL.</b>
                            <span>Используется для предотвращения случайного изменения URL.</span>
                            <span>Активируется после сохранения страницы с заполненным полем адрес.</span>
                        </div>
                    </div>
                </li>
				<li><label class=property>Адрес (URL)</label><div class="page_url">/</div><input name="url" class="page_url" type="text" value="{$page->url|escape}" /></li>
				<li><label class=property>Title (<span class="count_title_symbol"></span>/<span class="word_title"></span>)
                        <div class="helper_wrap">
                            <a href="javascript:;" id="show_help_search" class="helper_link"></a>
                            <div class="right helper_block">
                                <b>Название страницы</b>
                                <span>В скобках указывается количество символов/слов в строке</span>
                            </div>
                        </div>
                    </label>
                    <input name="meta_title" class="okay_inp" type="text" value="{$page->meta_title|escape}" /></li>
				<li><label class=property>Keywords (<span class="count_keywords_symbol"></span>/<span class="word_keywords"></span>)
                        <div class="helper_wrap">
                            <a href="javascript:;" id="show_help_search" class="helper_link"></a>
                            <div class="right helper_block">
                                <b>Ключевые слова страницы</b>
                                <span> В скобках указывается количество символов/слов в строке</span>
                            </div>
                        </div>
                    </label>
                    <input name="meta_keywords" class="okay_inp" type="text" value="{$page->meta_keywords|escape}" /></li>
				<li><label class=property>Description (<span class="count_desc_symbol"></span>/<span class="word_desc"></span>)
                        <div class="helper_wrap">
                            <a href="javascript:;" id="show_help_search" class="helper_link"></a>
                            <div class="right helper_block">
                                <b>Текст описания страницы,</b>
                                <span> который используется поисковыми системами для формирования сниппета.</span>
                                <span>В скобках указывается количество символов/слов в строке</span>
                            </div>
                        </div>
                    </label><textarea name="meta_description" class="okay_inp">{$page->meta_description|escape}</textarea></li>
			</ul>
		</div>
		<!-- Параметры страницы (The End)-->		

			
	</div>
	<!-- Левая колонка свойств товара (The End)--> 
		
	<!-- Описагние товара -->
	<div class="block layer">
		<h2>Текст страницы</h2>
		<textarea name="body"  class="editor_large">{$page->body|escape}</textarea>
	</div>
	<!-- Описание товара (The End)-->
	<input class="button_green button_save" type="submit" name="" value="Сохранить" />
	
</form>
<!-- Основная форма (The End) -->

