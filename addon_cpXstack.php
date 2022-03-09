#!/usr/bin/php -q
<?php
#WHMADDON:cpXstack:cpXstack
    //$user_domainfile = "/etc/trueuserdomains";
    //<##==##>
    require_once("/opt/pifpm/scripts/confs.php");
    require_once("/opt/pifpm/scripts/functions.php");
    require_once("/opt/pifpm/scripts/spyc.php");
    
    /*
     * Process here
     */
    if(isset($_POST['submit'])&& $_POST['submit'] == "submit"){
        $ignoreList = array("maxphp","copymax","submit");
        global $ulocation;
        foreach($_POST as $key=>$value){
            
            $user_file = $ulocation.$key."/details";
            
            if(in_array($key,$ignoreList)) continue;
            $user_details = getUserDetails($key);
            if($user_details['enabled'] != 1) continue;
            
            if(is_numeric($value))$user_details['max_fpm_process'] = $value;
            
             $command = "/opt/pifpm/scripts/set_fpm_max_process.sh"." ".$key." ".$value;
             system($command);
            
            $yamlString = yamlStringCreate($user_details);
            file_put_contents($user_file,$yamlString);
        }
        
    }
    /*
     * Process ends
     */
    $user = $_ENV['REMOTE_USER'];
    if($user != "root"){
        print("You do not have enough privilege to execute the script, Please
              check with the Server Administrator");
        exit(0);
    }
    $user_list = array();
   
    $userlisting = readFilenReturnArray("/etc/trueuserdomains");
    foreach($userlisting as $key=>$value){
        
        $tem_details = preg_split("/:/",$value);
        $username = $tem_details[1];
        $domainname = $tem_details[0];
        $username = pregReplace("/^\s|\\s$/","",$username);
        $username = pregReplace("/\\n/","",$username);
        $domainname = pregReplace("/^\s|\\s$/","",$domainname);
        $domainname = pregReplace("/\\n/","",$domainname);
        
        /*
         * Search filter start
         */
        if(isset($_POST['searchstring'])){
            if($_POST['searchmode'] == "exact"){
                if($_POST['searchstring'] == $domainname || $_POST['searchstring'] == $username){
                    $user_list = addtoUserlist($user_list,$username);
                }
            }elseif($_POST['searchmode'] == "contains"){
                if(searchString($domainname,$_POST['searchstring']) > 0 || searchString($username,$_POST['searchstring']) > 0){
                    $user_list = addtoUserlist($user_list,$username);
                }
            }
        }else{
        
            $user_list = addtoUserlist($user_list,$username); 
        }
        
    }
    
    
    function pregReplace($pattern,$replace,$subject){
        return preg_replace($pattern,$replace,$subject);
    }
    function searchString($haystack,$needle){
        return preg_match("/".$needle."/",$haystack);
    }
    function addtoUserlist($currentlist,$username){
        //status_class
        if(!in_array($username,$currentlist)){
            $user_details = getUserDetails($username);
            if($user_details['enabled'] == 1){
                $class = "enabled";
                $text = "Active";
                $readonly = "";
            }else{
                $class = "disabled";
                $text = "Inactive";
                $readonly = 'readonly="readonly"';
            }
            $class = ($user_details['enabled'] == 1)?"active":"inactive";
            $text = 
            $currentlist[] = array(
                                "user_name" => $username,
                                "enabled" => $user_details['enabled'],
                                "php_version" => $user_details['php_version'],
                                "max_fpm_process" => $user_details['max_fpm_process'],
                                "status_class" => $class,
                                "status" => $text,
                                "readonly" => $readonly,
                            );
        }
        
        
        return $currentlist;
    }
    function getUserDetails($username){
        
        global $ulocation;
        $user_file = $ulocation.$username."/details";
        $content = file_get_contents($user_file);
        $parsed_result = yamlparser($content);
        
        return $parsed_result;
    }
    
    
    
    
?>
<style>
    ul{border:0; margin:0; padding:0;}
    #pagination-flickr li{
    border:0; margin:0; padding:0;
    font-size:11px;
    list-style:none;
    }
    #pagination-flickr a{
    border:solid 1px #DDDDDD;
    margin-right:2px;
    }
    #pagination-flickr .previous-off,
    #pagination-flickr .next-off {
    color:#666666;
    display:block;
    float:left;
    font-weight:bold;
    padding:3px 4px;
    margin-right:2px;
    }
    #pagination-flickr .next a,
    #pagination-flickr .previous a {
    font-weight:bold;
    border:solid 1px #FFFFFF;
    } 
    #pagination-flickr .active{
    color:#005264;
    border:solid 1px #DDDDDD;
    background-color:#DDDDDD;
    margin-right:2px;
    display:block;
    float:left;
    padding:3px 4px;
    }
    #pagination-flickr a:link,
    #pagination-flickr a:visited {
    color:#52828c;
    display:block;
    float:left;
    padding:3px 6px;
    text-decoration:none;
    }
    #pagination-flickr a:hover{
    border:solid 1px #666666;
    }
    .active{
        background-color:#1a3300;
        color:#ffffff;
    }
    .inactive{
        background-color:#fec5ca;
        color:#000000;
    }
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script>
    
    function copyValues(value){
        if(!$('#copymax').is(':checked')) return false;
        
        if(!checkIfNumber(value) ) {
           alert("Max Process limit accepts only number, Please make sure if the entered string is a number");
           $('#copymax').attr('checked',false);
           $('#maxphp').focus();
           return false;
        }
        $('.userdetails input').each(function(index) {
            var isReadonly = $(this).attr('readonly');

            if($(this).attr('id') != "submit" && isReadonly != "readonly") $(this).val(value);
        });
    }
    
    function validateAll(){
        var alliswell = true;
        $('.userdetails input').each(function(index) {
            if($(this).attr('id') != "submit") if(!checkIfNumber($(this).val())) alliswell = false;
        });
        if(!alliswell){
            alert("Process limit accepts only number, Please make sure if the entered string is a number");
            return false;
        }
        
        //$("form#tenga").submit();
        $("#tenga").submit();
    }
    
    function checkIfNumber(value){
        
        
        var intRegex = /^\d+$/;
        if(intRegex.test(value) ) return true;
        
        return false;
    }
    
    function searchit(){
        if($("#searchstring").val() == ""){
            alert("Please fill in Domain name or an Account name to search");
            return false;
        }
        $("form#searchset").submit();
    }
</script>
<div style="width:100%;position:relative;float:left;border:solid 1px #004040;">
    <div style="width:100%;position:relative;float:left;text-align:center;background-color:#52828c;color:#fff;">
        cpXstack - PHP-FPM Process Manager
    </div>
    <div style="width:67.3%;position:relative;float:left;margin-left:15%;margin-bottom:5px;margin-top:3px;background-color:#f2f2f2;text-align:center;border:solid 1px gray;" >
        <table class="searchtbl">
            <form name="searchset" id="searchset" method="post">
                <tbody>
                    <tr>
                        <th>Search <span style="font-weight:lighter;font-size:small;color:greay;">(Username)</span>:</th>
                        <td>
                            <input id="searchstring" type="text" name="searchstring" />
                            <input   name="searchacc" id="searchacc" type="button" value="Search"  onclick="searchit()"/>
                        </td> 
                    </tr>
                    <tr>
                        <th>Search Mode :</th>
                        <td>
                            <label title="Match exact word">
                                <input type="radio" name="searchmode" value="exact" checked="checked"/>
                                <span>Match exact word</span>
                            </label>
                            <label title="Match exact word">
                                <input type="radio" name="searchmode" value="contains"/>
                                <span>Match containing </span>
                            </label>
                        </td>
                    </tr>
                </tbody>
            </form>
        </table>
    </div>
    <div style="width:75%;position:relative;float:left;margin-left:15%;text-align:center;" id="datahold">
        <table cellspacing="1" cellpadding="1" style="width:90%;" >
            <form name="tenga" id="tenga" method="post">
                <thead>
                    <tr style="background-color:#cfcfcf;">
                        <td>#</td>
                        <td>User Name</td>
                        <td >Max Process</td>
                        <td >Status</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr style="background-color:#eae1e1;">
                        <td colspan="5" style="text-align:center;background-color:#f2f2f2;">Max Process
                            <input type="input" id="maxphp" name="maxphp"/>
                            <span>Copy to all active users: <input type="checkbox" id="copymax" name="copymax" onchange="copyValues($('#maxphp').val())"/></span></td>
                        <!--<td colspan="1" ></td>
                        <td colspan="2"></td>-->
                    </tr>
                </thead>
                <tbody class="userdetails">
                    
                    <?php
                        $count = 1;
                        $nextcolor = "";
                        foreach($user_list as $key=>$value){
                            $color = ($count%2 == 0)?"#eae1e1":"#cfcfcf";
                            $nextcolor = ($nextcolor%2 == 0)?"#cfcfcf":"#eae1e1";
                            //max_fpm_process
                            ?>
                            <tr style="background-color:<?php print($color); ?> ">
                                <td><?php print($count); ?></td>
                                <td><?php print($value['user_name'])?></td>
                                <td><input <?php print($value['readonly']); ?> value="<?php print($value['max_fpm_process']); ?>" type="text"   id="<?php print($value['user_name']);?>" name="<?php print($value['user_name']);?>"/></td>
                                <td class="<?php print($value['status_class']); ?>"><?php print($value['status']); ?></td>
                                <td></td>
                            </tr>
                            <?php
                            $count++;
                        }
                    ?>
                    <tr style="background-color:<?php print($nextcolor); ?> ">
                        <td colspan="5"><input type="submit" name="submit" id="submit" value="submit" onclick="validateAll();return false;" /></td>
                    </tr>
                    
                </tbody>
            </form>
        </table>
    </div>
    <!--<div style="width:100%;position:relative;float:left;">
        <div style="width:50%;position:relative;float:left;margin-left:30%;">
            <tr>
                <ul id="pagination-flickr">
                    <li class="previous-off">Previous</li>
                    <li class="active">1</li>
                    <li><a href="?page=2">2</a></li>
                    <li><a href="?page=3">3</a></li>
                    <li><a href="?page=4">4</a></li>
                    <li><a href="?page=5">5</a></li>
                    <li><a href="?page=6">6</a></li>
                    <li><a href="?page=7">7</a></li>
                    <li class="next"><a href="?page=2">Next >></a></li>
                </ul>
            </tr>
        </div>
    </div>-->
</div>
<?php

    
    function readCSVnReturnArray($file,$arranged = false){
        
        if(empty($file)) return false;
        $file_contents = readFilenReturnArray($file);
        if(!$file_contents) return false;
        $string_line_1 = preg_split("/,/",$file_contents[0]);
        $start = 0;
        $collector = array();
        $appender = "loc";
        foreach($string_line_1 as $key=>$value){
            $collector[] = ($arranged)?$value:$appender.$start;
            $start++;
        }
        $start = 0;
         
    }
    
?>
