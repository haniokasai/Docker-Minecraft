<?php
//https://stackoverflow.com/questions/11597421/how-to-get-the-newest-file-in-a-directory-in-php
@$files = scandir('/minecraft/server/crashdumps/', SCANDIR_SORT_DESCENDING);
if(@$newest_file = $files[0]){
	//https://memorandum-plus.com/2018/06/07/php-文字列中から特定の部分を切り出す（substr、strlen、strpos/
	//対象の文字列
	@$target_text = fgets(fopen($newest_file, 'r'));
	//開始位置
	@$start_position = strpos($target_text, "===BEGIN CRASH DUMP===") + strlen("===BEGIN CRASH DUMP===");
	//切り出す部分の長さ
	@$length = strpos($target_text, "===END CRASH DUMP===") - $start_position;
	//切り出し
	print substr($target_text, $start_position, $length );

}else{
	echo "クラッシュダンプなし";
}