{* Вкладки *}
{capture name=tabs}
    {if in_array('orders', $manager->permissions)}
        <li {if $status===0}class="active"{/if}>
            <a href="{url module=OrdersAdmin status=0 keyword=null id=null page=null label=null from_date=null to_date=null}">Новые</a>
        </li>
        <li {if $status==1}class="active"{/if}>
            <a href="{url module=OrdersAdmin status=1 keyword=null id=null page=null label=null from_date=null to_date=null}">Приняты</a>
        </li>
        <li {if $status==2}class="active"{/if}>
            <a href="{url module=OrdersAdmin status=2 keyword=null id=null page=null label=null from_date=null to_date=null}">Выполнены</a>
        </li>
        <li {if $status==3}class="active"{/if}>
            <a href="{url module=OrdersAdmin status=3 keyword=null id=null page=null label=null from_date=null to_date=null}">Удалены</a>
        </li>
        {if $keyword}
            <li class="active">
                <a href="{url module=OrdersAdmin keyword=$keyword id=null label=null from_date=null to_date=null}">Поиск</a>
            </li>
        {/if}
    {/if}
    <li class="okay_lite disabled"><a href="javascript:;" title="Доступно в полной версии Okay CMS">Метки</a></li>
{/capture}

{* Title *}
{$meta_title='Заказы' scope=parent}

{literal}
    <script src="design/js/jquery/datepicker/jquery.ui.datepicker-ru.js"></script>
{/literal}
{* Поиск *}
<form id="search_form" method="get">
 
    <div id="search">
    	<input type="hidden" name="module" value="OrdersAdmin">
    	<input class="search" type="text" name="keyword" value="{$keyword|escape}"/>
    	<input class="search_button" type="submit" value=""/> 
    </div>

    <div class="helper_wrap">
       <a href="javascript:;" id="show_help_search" class="helper_link"></a> 
       <div class="search_help helper_block">
            <b>В поиске участвуют следующие данные:</b>
            <span>1.    Номер заказа</span>
            <span>2.    Имя покупателя</span>
            <span>3.    Телефон</span>
            <span>4.    Адрес</span>
            <span>5.    E-mail</span>
            <span>6.    Название товара или название варианта товара в заказе</span>
        </div>
    </div> 
</form>

	
{* Заголовок *}
<div id="header">
	<h1>{if $orders_count}{$orders_count}{else}Нет{/if} заказ{$orders_count|plural:'':'ов':'а'}</h1>
	<a class="add" href="{url module=OrderAdmin}">Добавить заказ</a>
</div>	

{if $message_error}
<!-- Системное сообщение -->
<div class="message message_error">
	<span class="text">{if $message_error=='error_closing'}Нехватка некоторых товаров на складе{else}{$message_error|escape}{/if}</span>
	{if $smarty.get.return}
	<a class="button" href="{$smarty.get.return}">Вернуться</a>
	{/if}
</div>
{/if}

{if $orders}
    <div id="main_list">

        {include file='pagination.tpl'}

        <form id="form_list" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">

            <div id="list">
                {foreach $orders as $order}
                    <div class="{if $order->paid}green{/if} row">
                        <div class="checkbox cell">
                            <input type="checkbox" id="{$order->id}" name="check[]" value="{$order->id}"/>
                            <label for="{$order->id}"></label>
                        </div>
                        <div class="order_date cell">
                            {$order->date|date} в {$order->date|time}
                        </div>

                        <div class="order_name cell">

                            <div class="order_info_wrap">
                                 <a class="show_purchases" href="javascript:;"><span>{$order->purchases|count}</span><i class="info_icon"></i></a>

                                <div class="order_info">
                                    <p>Товары в заказе №{$order->id}</p>
                                    <table class="orders_purchases">
                                        {foreach $order->purchases as $purchase}
                                            <tr>
                                                <td>
                                                {$purchase->product_name}
                                                {if $purchase->variant_name}({$purchase->variant_name}){/if}
                                                </td>
                                                <td>{$purchase->price}</td>
                                                <td>{$purchase->amount}{$settings->units}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                </div>
                            </div>

                           
                            <a href="{url module=OrderAdmin id=$order->id return=$smarty.server.REQUEST_URI}">Заказ №{$order->id}</a> 
                            <span>{$order->name|escape}</span>

                            {if $order->note}
                                <div class="note">{$order->note|escape}</div>
                            {/if}
                            
                            
                        </div>

                        <div class="name cell" style='white-space:nowrap;'>
                            {$order->total_price|escape} {$currency->sign}
                        </div>

                        <div class="icons cell">
                            <a href='{url module=OrderAdmin id=$order->id view=print}' target="_blank" class="print" title="Печать заказа"></a>
                            <a href='#' class=delete title="Удалить"></a>
                        </div>

                         <div class="icons cell">
                            {if $order->paid}
                                <img src='design/images/moneybox_paid.png'  alt='Оплачен' title='Оплачен'>
                            {else}
                                <img src='design/images/moneybox.png'  alt='Не оплачен' title='Не оплачен'>
                            {/if}
                        </div>

                       
                        {if $keyword}
                            <div class="icons cell">
                                {if $order->status == 0}
                                    <img src='design/images/new.png' alt='Новый' title='Новый'>
                                {/if}
                                {if $order->status == 1}
                                    <img src='design/images/time.png' alt='Принят' title='Принят'>
                                {/if}
                                {if $order->status == 2}
                                    <img src='design/images/tick.png' alt='Выполнен' title='Выполнен'>
                                {/if}
                                {if $order->status == 3}
                                    <img src='design/images/cross.png' alt='Удалён' title='Удалён'>
                                {/if}
                            </div>
                        {/if}

                        <div class="clear"></div>
                    </div>
                {/foreach}
            </div>

            <div id="action">
                <label id='check_all' class="dash_link">Выбрать все</label>
                <span id="select">
                <select name="action">
                    {if $status!==0}
                        <option value="set_status_0">В новые</option>
                    {/if}
                    {if $status!==1}
                        <option value="set_status_1">В принятые</option>
                    {/if}
                    {if $status!==2}
                        <option value="set_status_2">В выполненные</option>
                    {/if}
                    <option value="delete">Удалить выбранные заказы</option>
                </select>
                </span>
                <input id="apply_action" class="button_green" type="submit" value="Применить">
            </div>
        </form>

        {include file='pagination.tpl'}
    </div>
{/if}


<div id="right_menu">

</div>




{* On document load *}
{literal}
<script>

$(function() {


    $("#from_date, #to_date").datepicker({
        dateFormat: 'dd-mm-yy'
    });

    $('.show_purchases').on('click',function(){
       $(this).next().slideToggle(300);
    });
	

	$("#main_list #list .row").droppable({
		activeClass: "drop_active",
		hoverClass: "drop_hover",
		tolerance: "pointer",
		drop: function(event, ui){
			label_id = $(ui.helper).attr('data-label-id');
			$(this).find('input[type="checkbox"][name*="check"]').attr('checked', true);
			$(this).closest("form").find('select[name="action"] option[value=set_label_'+label_id+']').attr("selected", "selected");		
			$(this).closest("form").submit();
			return false;	
		}		
	});
	
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

	// Подтверждение удаления
	$("form").submit(function() {
		if($('#list input[type="checkbox"][name*="check"]:checked').length>0)
			if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
				return false;	
	});
});

</script>
{/literal}
