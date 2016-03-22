{* Вкладки *}
{capture name=tabs}
    <li class="active"><a href="index.php?module=UsersAdmin">Пользователи</a></li>
    {if in_array('groups', $manager->permissions)}
        <li><a href="index.php?module=GroupsAdmin">Группы</a></li>
    {/if}
    {if in_array('coupons', $manager->permissions)}
        <li><a href="index.php?module=CouponsAdmin">Купоны</a></li>
    {/if}
    <li class="okay_lite disabled"><a href="javascript:;" title="Доступно в полной версии Okay CMS">Подписчики</a></li>
{/capture}

{* Title *}
{$meta_title='Покупатели' scope=parent}

{* Поиск *}
{if $users || $keyword}
<form method="get">
<div id="search">
	<input type="hidden" name="module" value='UsersAdmin'>
	<input class="search" type="text" name="keyword" value="{$keyword|escape}" />
	<input class="search_button" type="submit" value=""/>
</div>
</form>
{/if}

<div id="header">
	{if $keyword && $users_count>0}
	<h1>{$users_count|plural:'Нашелся':'Нашлось':'Нашлись'} {$users_count} {$users_count|plural:'покупатель':'покупателей':'покупателя'}</h1>
	{elseif $users_count>0}
	<h1>{$users_count} {$users_count|plural:'покупатель':'покупателей':'покупателя'}</h1> 	
	{else}
	<h1>Нет покупателей</h1> 	
	{/if}
	{if $users_count>0}
	<form method="post" action="{url module=ExportUsersAdmin}" target="_blank">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="image" src="./design/images/export_excel.png" name="export" title="Экспортировать этих покупателей">
	</form>
	{/if}
	
</div>

{if $users}
    <div id="main_list">
        {include file='pagination.tpl'}
        <div id="sort_links" style='display:block;'>
            Упорядочить по
            {if $sort!='name'}<a href="{url sort=name}">имени</a>{else}имени{/if} или
            {if $sort!='date'}<a href="{url sort=date}">дате</a>{else}дате{/if}
        </div>

        <form id="form_list" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">

            <div id="list">
                {foreach $users as $user}
                    <div class="{if !$user->enabled}invisible{/if} row">
                        <div class="checkbox cell">
                            <input type="checkbox" id="{$user->id}" name="check[]" value="{$user->id}"/>
                            <label for="{$user->id}">
                        </div>
                        <div class="user_name cell">
                            <a href="index.php?module=UserAdmin&id={$user->id}">{$user->name|escape}</a>
                        </div>
                        <div class="user_email cell">
                            <a href="mailto:{$user->name|escape}<{$user->email|escape}>">{$user->email|escape}</a>
                        </div>
                        <div class="user_group cell">
                            {$groups[$user->group_id]->name}
                        </div>
                        <div class="icons cell user">
                            <a class="enable" title="Активен" href="#"></a>
                            <a class="delete" title="Удалить" href="#"></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                {/foreach}
            </div>

            <div id="action">
                <label id="check_all" class="dash_link">Выбрать все</label>
                <span id=select>
                <select name="action">
                    <option value="disable">Заблокировать</option>
                    <option value="enable">Разблокировать</option>
                    <option value="delete">Удалить</option>
                </select>
                </span>
                <input id="apply_action" class="button_green" type="submit" value="Применить">
            </div>

        </form>
        {include file='pagination.tpl'}
    </div>
{/if}

<div id="right_menu">
	<ul>
		<li {if !$group->id}class="selected"{/if}><a href='index.php?module=UsersAdmin'>Все группы</a></li>
	</ul>
	{if $groups}
        <ul>
            {foreach $groups as $g}
            <li {if $group->id == $g->id}class="selected"{/if}>
                <a href="index.php?module=UsersAdmin&group_id={$g->id}">{$g->name}</a>
            </li>
            {/foreach}
        </ul>
	{/if}
		
</div>
{literal}
<script>
$(function() {

	// Раскраска строк
	function colorize()
	{
		$("#list div.row:even").addClass('even');
		$("#list div.row:odd").removeClass('even');
	}
	// Раскрасить строки сразу
	colorize();
	
	// Выделить все
	$("#check_all").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length>0);
	});	

	// Удалить 
	$("a.delete").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
		$(this).closest(".row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
		$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
		$(this).closest("form").submit();
	});
	
	// Скрыт/Видим
	$("a.enable").click(function() {
		var icon        = $(this);
		var line        = icon.closest(".row");
		var id          = line.find('input[type="checkbox"][name*="check"]').val();
		var state       = line.hasClass('invisible')?1:0;
		icon.addClass('loading_icon');
		$.ajax({
			type: 'POST',
			url: 'ajax/update_object.php',
			data: {'object': 'user', 'id': id, 'values': {'enabled': state}, 'session_id': '{/literal}{$smarty.session.id}{literal}'},
			success: function(data){
				icon.removeClass('loading_icon');
				if(state)
					line.removeClass('invisible');
				else
					line.addClass('invisible');				
			},
			dataType: 'json'
		});	
		return false;	
	});
	
	// Подтверждение удаления
	$("form").submit(function() {
		if($('#list input[type="checkbox"][name*="check"]:checked').length>0)
			if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
				return false;	
	});
});

</script>
{/literal}
