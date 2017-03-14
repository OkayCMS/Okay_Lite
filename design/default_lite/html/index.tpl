<!DOCTYPE html>
<html {if $language->label}lang="{$language->label|escape}"{/if} prefix="og: http://ogp.me/ns#">
<head>
	{* Полный базовый адрес *}
	<base href="{$config->root_url}/"/>
	{* Метатеги *}
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    {* Тайтл страницы *}
    <title>{$meta_title|escape}{$filter_meta->title|escape}</title>
    {if (!empty($meta_description) || !empty($meta_keywords) || !empty($filter_meta->description) || !empty($filter_meta->keywords)) && !$smarty.get.page}
        <meta name="description" content="{$meta_description|escape}{$filter_meta->description|escape}"/>
        <meta name="keywords" content="{$meta_keywords|escape}{$filter_meta->keywords|escape}"/>
    {/if}
	{if $module == 'ProductsView'}
        {if $set_canonical}
		    <meta name="robots" content="noindex,nofollow"/>
        {elseif $smarty.get.page || $smarty.get.sort}
            <meta name="robots" content="noindex,follow"/>
        {elseif isset($smarty.get.keyword)}
            <meta name="robots" content="noindex,follow"/>
        {else}
            <meta name="robots" content="index,follow"/>
        {/if}
    {else}
    	<meta name="robots" content="index,follow"/>
	{/if}
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <meta name="generator" content="OkayCMS Lite {$config->version}"/>
	{$rel_prev_next}

	{* Изображения товара и поста для соц. сетей *}
	{if $module == 'ProductView'}
        <meta property="og:url" content="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}"/>
        <meta property="og:type" content="article"/>
        <meta property="og:title" content="{$product->name|escape}"/>
        <meta property="og:description" content="{$product->annotation|strip_tags}" />
        <meta property="og:image" content="{$product->image->filename|resize:330:300}"/>
        <link rel="image_src" href="{$product->image->filename|resize:330:300}"/>
        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$product->name|escape}">
        <meta name="twitter:description" content="{$product->annotation|strip_tags}">
        <meta name="twitter:image" content="{$product->image->filename|resize:330:300}">
	{elseif $module == 'BlogView'}
		<meta property="og:url" content="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}"/>
		<meta property="og:type" content="article"/>
		<meta property="og:title" content="{$post->name|escape}"/>
        {if $post->image}
            <meta property="og:image" content="{$post->image|resize:400:300:false:$config->resized_blog_dir}"/>
            <link rel="image_src" href="{$post->image|resize:400:300:false:$config->resized_blog_dir}"/>
        {else}
            <meta property="og:image" content="{$config->root_url}/design/{$settings->theme}/images/logo_ru.png" />
            <meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme}/images/logo_ru.png">
        {/if}
		<meta property="og:description" content='{$post->annotation|strip_tags}'/>

        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$post->name|escape}">
        <meta name="twitter:description" content="{$post->annotation|strip_tags}">
        <meta name="twitter:image" content="{$post->image|resize:400:300:false:$config->resized_blog_dir}">
    {else}
        <meta property="og:title" content="{$settings->site_name}" />
        <meta property="og:type" content="website"/>
        <meta property="og:url" content="{$config->root_url}"/>
        <meta property="og:image" content="{$config->root_url}/design/{$settings->theme}/images/logo_ru.png" />
        <meta property="og:site_name" content="{$settings->site_name}"/>
        <meta property="og:description" content="{$meta_description|escape}"/>
        <link rel="image_src" href="{$config->root_url}/design/{$settings->theme}/images/logo_ru.png"/>
        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$settings->site_name}">
        <meta name="twitter:description" content="{$meta_description|escape}">
        <meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme}/images/logo_ru.png">
    {/if}

	{* Канонический адрес страницы *}
	{if isset($canonical)}
        <link rel="canonical" href="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}"/>
	{elseif $smarty.get.sort}
		<link rel="canonical" href="{$sort_canonical}"/>
    {/if}

	{* Языковый атрибут *}
    {foreach $languages as $l}
		{if $l->enabled}
            <link rel="alternate" hreflang="{$l->label}" href="{$config->root_url}/{$l->url}"/>
		{/if}
	{/foreach}

	{* Иконка сайта *}
	<link href="design/{$settings->theme}/images/favicon.png" type="image/x-icon" rel="icon"/>
	<link href="design/{$settings->theme}/images/favicon.png" type="image/x-icon" rel="shortcut icon"/>

	{* JQuery *}
	<script src="design/{$settings->theme}/js/jquery-2.1.4.min.js"></script>

	{* JQuery UI *}
	{* Библиотека с "Slider", "Transfer Effect" *}
	<script src="design/{$settings->theme}/js/jquery-ui.min.js"></script>

	{* Fancybox *}
	<script src="design/{$settings->theme}/js/jquery.fancybox.min.js"></script>

	{* Autocomplete *}
	<script src="design/{$settings->theme}/js/jquery.autocomplete-min.js"></script>

	{* slick slider *}
	<script src="design/{$settings->theme}/js/slick.min.js"></script>

	{* Карточка товаров, поделиться в соц. сетях *}
	{if $smarty.get.module == 'ProductView' || $smarty.get.module == "BlogView"}
		<script type="text/javascript" src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
		<script type="text/javascript" src="//yastatic.net/share2/share.js"></script>
	{/if}

	{* Стили *}
	<link href="design/{$settings->theme|escape}/css/bootstrap.css" rel="stylesheet"/>
	<script src="design/{$settings->theme|escape}/js/bootstrap.min.js"></script>

	{* Okay *}
	{include file="scripts.tpl"}
	<script src="design/{$settings->theme}/js/okay_lite.js"></script>

	{* Всплывающие подсказки для администратора *}
	{if $smarty.session.admin}
		<script src ="backend/design/js/admintooltip/admintooltip.js"></script>
        <link href="backend/design/js/admintooltip/styles/admin.css" rel="stylesheet"/>
	{/if}

	{* js-проверка форм *}
	<script src="design/{$settings->theme}/js/baloon.js"></script>
</head>
<body>
<div class="border-b-1-info">
	<div class="container">
		{* Кнопка меню для моб. *}
		<button class="i-mob-menu" data-target="#mob-menu" data-toggle="collapse" type="button" aria-expanded="false">
			&#9776;
		</button>

		{* Меню сайта *}
		<ul id="mob-menu" class="nav nav-inline pull-xs-left nav-mob collapse">
			{foreach $pages as $p}
				{if $p->menu_id == 1}
					<li class="nav-item">
						<a class="nav-link" data-page="{$p->id}" href="{$lang_link}{$p->url}">{$p->name|escape}</a>
					</li>
				{/if}
			{/foreach}
		</ul>

		<ul class="nav nav-inline pull-xs-right">
            {* Выбор валюты *}
            {if $currencies|count > 1}
                <li class="nav-item">
                    <div class="btn-group">
                        <a class="nav-link link-black i-cur" href="#" data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            <span class="cur-label">{$currency->sign}</span>
                            <span class="cur-name">{$currency->name}</span>
                        </a>
                        <div class="dropdown-menu">
                            {foreach $currencies as $c}
                                {if $c->enabled}
                                    <a class="dropdown-item {if $currency->id== $c->id}active{/if}" href="{url currency_id=$c->id}">
                                        <span class="cur-label">{$c->name}</span>
                                        <span class="cur-name">{$c->name}</span>
                                    </a>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </li>
            {/if}

			{* Выбор языка *}
			{if $languages|count > 1}
                {$cnt = 0}
                {foreach $languages as $ln}
                    {if $ln->enabled}
                        {$cnt = $cnt+1}
                    {/if}
                {/foreach}
                {if $cnt>1}
                    <li class="nav-item">
                        <div class="btn-group">
                            <a data-languages="true" class="nav-link link-black i-lang" href="#" data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false"><span class="lang-label">{$language->label}</span><span
                                        class="lang-name">{$language->{'name_'|cat:$language->label}}</span></a>
                            <div class="dropdown-menu">
                                {foreach $languages as $l}
                                    {if $l->enabled}
                                        <a class="dropdown-item{if $language->id == $l->id} active{/if}"
                                           href="{$l->url}"><span class="lang-label">{$l->label}</span><span
                                                    class="lang-name">{$l->{'name_'|cat:$language->label}}</span></a>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    </li>
                {/if}
			{/if}

			{if $user}
				{* Личный кабинет *}
				<li class="nav-item">
					<a class="nav-link link-black i-user" href="{$lang_link}user">{$user->name}</a>
				</li>
			{else}
				{* Вход *}
				<li class="nav-item">
					<a class="nav-link link-black i-user" href="{$lang_link}user/login" title="{$lang->index_login}"><span data-language="{$translate_id['index_login']}">{$lang->index_login}</span></a>
				</li>
			{/if}
		</ul>
	</div>
</div>

<div class="container m-y-1">
	<div class="row">
		{* Логотип сайта *}
		<div class="col-xs-6 col-lg-3 text-md-right p-r-0-md_down">
			<a href="{$lang_link}">
				<img class="img-fluid logo_fix" src="design/{$settings->theme|escape}/images/logo{if $language->label}_{$language->label}{/if}.png" alt="{$settings->site_name|escape}"/>
			</a>
		</div>

		{* Информер корзины *}
		<div id="cart_informer" class="col-xs-6 col-lg-2 pull-lg-right">
			{include file='cart_informer.tpl'}
		</div>

		{* Форма поиска *}
		<div class="col-xs-12 col-lg-3 m-y-1-md_down">
			<form id="fn-search" class="input-group" action="{$lang_link}all-products">
				<input class="fn-search okaycmslite form-control" type="text" name="keyword" value="{$keyword|escape}" data-language="{$translate_id['index_search']}" placeholder="{$lang->index_search}"/>
				<span class="input-group-btn">
					<button class="i-search" type="submit"></button>
				</span>
			</form>
		</div>

		{* Телефоны *}
		<div class="col-xs-8 col-lg-2 p-l-0 p-l-1-md_down">
			<div class="i-phone h5 font-weight-bold">
				<div><a class="link-black" href="tel:{$lang->index_phone_1}" data-language="{$translate_id['index_phone_1']}" >{$lang->index_phone_1}</a></div>
				<div><a class="link-black" href="tel:{$lang->index_phone_2}" data-language="{$translate_id['index_phone_2']}" >{$lang->index_phone_2}</a></div>
			</div>
		</div>
	</div>
</div>
{* Категории товаров *}
{function name=categories_tree}
	{if $categories}
		{* Первая итерация *}
		{if $level == 1}
			<div class="container p-x-0_md-down m-b-1">
				<div class="border-b-1-white hidden-lg-up">
					<button class="text-sm-center btn btn-block brad-0 btn-primary dropdown-toggle" type="button" data-toggle="collapse" data-target="#catalog" aria-expanded="false" aria-controls="catalog">{$lang->index_catalog}</button>
					</div>
				<nav class="navbar navbar-dark bg-primary">
					<ul id="catalog" class="nav navbar-nav collapse">
		{* Последующие итерации *}
		{else}
			<ul id="{$parent_id}" class="navbar-sub collapse">
		{/if}
            {foreach $categories as $c}
                {if $c->visible}
                    {if $c->subcategories && $level == 1}
                        <li class="nav-item">
                        <button class="btn-category-collapse collapsed" type="button" data-toggle="collapse" data-target="#{$c->id}" aria-expanded="false" aria-controls="{$c->id}"></button>
                            <a class="nav-link" href="{$lang_link}catalog/{$c->url}" data-category="{$c->id}">{$c->name|escape}</a>
                            {if $c->subcategories|count > 1}
                                {categories_tree categories=$c->subcategories level=$level + 1 parent_id=$c->id two_col=true}
                            {else}
                                {categories_tree categories=$c->subcategories level=$level + 1 parent_id=$c->id}
                            {/if}
                        </li>
                    {else}
                        <li class="nav-item">
                            <a class="nav-link" href="{$lang_link}catalog/{$c->url}" data-category="{$c->id}">{$c->name|escape}</a>
                        </li>
                    {/if}
                {/if}
            {/foreach}
		{* Первая итерация *}
		{if $level == 1}
					</ul>
				</nav>
			</div>
		{* Последующие итерации *}
		{else}
			</ul>
		{/if}

	{/if}
{/function}
{categories_tree categories=$categories level=1}

{* Баннер *}
{if $smarty.get.module == "MainView"}
	<div class="container hidden-md-down">
		<div class="fn-slick-banner okaycmslite slick-banner m-b-1">
            <div>
                <a href="/" target="_blank">
                    <img src="design/{$settings->theme}/images/1.png" alt="1" title="1"/>
                    <span class="slick-name">1</span>
                </a>
            </div>
            <div>
                <a href="/" target="_blank">
                    <img src="design/{$settings->theme}/images/3.png" alt="3" title="3"/>
                    <span class="slick-name">3</span>
                </a>
            </div>
		</div>
	</div>
{/if}
{* Баннер *}
{* Тело сайта *}
<div id="fn-content">
	{$content}
</div>

{* Футер сайта *}
<div class="bg-blue p-y-1">
	<div class="container">
		<div class="row text-white">
			{* Меню сайта *}
			<div class="col-xs-6 col-lg-3 l-h-1_7 m-b-1-md_down">
				<div class="h5">
					<span data-language="{$translate_id['index_about_store']}">{$lang->index_about_store}</span>
				</div>
				{foreach $pages as $p}
					{* Выводим только страницы из первого меню *}
					{if $p->menu_id == 1}
						<div>
							<a class="link-white" href="{$lang_link}{$p->url}">{$p->name|escape}</a>
						</div>
					{/if}
				{/foreach}
			</div>

			{* Каталог *}
			<div class="col-xs-6 col-lg-3 l-h-1_7 m-b-1-md_down">
				<div class="h5">
					<span data-language="{$translate_id['login_enter']}">{$lang->index_catalog}</span>
				</div>
				{foreach $categories as $c}
                    {if $c->visible}
                        <div>
                            <a class="link-white" href="{$lang_link}catalog/{$c->url}">{$c->name|escape}</a>
                        </div>
                    {/if}
				{/foreach}
			</div>
            <div class="clearfix hidden-lg-up"></div>
			{* Контакты *}
			<div class="col-xs-6 col-lg-3 l-h-1_7">
				<div class="h5">
					<span data-language="{$translate_id['index_contacts']}">{$lang->index_contacts}</span>
				</div>
				<div class="text-nowrap" data-language="{$translate_id['index_contacts_body']}">{$lang->index_contacts_body}</div>
			</div>
			{* Соц. сети *}
			<div class="col-xs-6 col-lg-3">
				<div class="h5">
					<span data-language="{$translate_id['index_in_networks']}">{$lang->index_in_networks}</span>
				</div>
				<div>
					<a class="i-soc i-fb" href="{$lang_link}#" target="_blank"></a>
					<a class="i-soc i-vk" href="{$lang_link}#" target="_blank"></a>
					<a class="i-soc i-tw" href="{$lang_link}#" target="_blank"></a>
				</div>
			</div>
		</div>
	</div>
</div>
<!--OkayCMS Lite-->
{* Копирайт *}
<div class="container p-y-1">
	© {$smarty.now|date_format:"%Y"}. <a class="link-black" href="http://okay-cms.com" target="_blank"><span data-language="{$translate_id['index_copyright']}">{$lang->index_copyright}</span></a>
</div>
</body>
</html>