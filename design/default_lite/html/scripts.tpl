<script>
	/* Глобальный обьект */
	/* все глобальные переменные добавляем в оъект и работаем с ним!!! */
	var okay = {literal}{}{/literal};
	{* Ошибка при отправке комментария в посте *}
	{if $smarty.get.module == 'BlogView' && $error}
		{* Переход по якорю к форме *}
		$( window ).load( function() {
			location.href = location.href + '#fn-blog_comment';
			$( '#fn-blog_comment' ).trigger( 'submit' );
		} );
	{/if}
	{* Карточка товара, ошибка в форме *}
	{if $smarty.get.module == 'ProductView' && $error}
		$( window ).load( function() {
			$( 'a[href="#comments"]' ).tab( 'show' );
			location.href = location.href + '#comments';
		} );
	{* Карточка товара, отправка комментария *}
	{elseif $smarty.get.module == 'ProductView'}
		$( window ).load( function() {
			if( location.hash.search('comment') !=-1 ) {
				$( 'a[href="#comments"]' ).tab( 'show' );
			}
		} );
	{/if}
    {if $smarty.get.module == "MainView" || $smarty.get.module == "ProductsView" || $smarty.get.module == "ProductView" || $smarty.get.module == "ComparisonView" || $smarty.get.module == "WishlistView"}
    $(document).ready(function(){
        $('select[name=variant]').each(function(){
            var first_in_stock = $(this).find('option[data-stock!="0"]').first();
            first_in_stock.attr('selected',true);
            first_in_stock.trigger('change');
        });
    });
    {/if}
</script>
<!--OkayCMS Lite-->