onLoad = function () {
    $('body').append(_.template($('#usage_template').text()));

    var $package_selector = $('.search_package');

    $.get('/api/jdoc', function (jdocs) {
        console.log(jdocs);
        jdocs.forEach(function(jdoc) {
            $package_selector.append('<option value=' + jdoc.url + '>' + jdoc.simple_name + '</option>');
        });
    });

    $('.search_box').on('keypress', function (event) {
        if (event.which == 13) {
            joogleSearch();
        }
    });
};

joogleSearch = function () {
    query = $('.search_box').val();
    /* pack = $('.search_package').val(); */

    if (!query/* || !pack*/) {
        return;
    }

    $('.usage').remove();
    $('.result').remove();
    $('body').append(_.template($('#result_template').text()));

    var method_template = _.template($('#method_template').text());
    var method_template_sample = _.template($('#method_template_sample').text());
    var package_template = _.template($('#package_template').text());

    var $result = $('.result');
    var $packages = $('.packages', $result);
    var $functions = $('.functions', $result);
    
    $functions.empty();
    $functions.append('<div class="accordion"></div>');

    var $accordion = $('.accordion', $functions);


    query = $('.search_box').val();
    pack = $('.search_package').val();

    $.get('/api/search?query=' + query, function (data){
        /*data.packages.forEach(function (pack){
            $packages.append(package_template(pack));
        });*/
        data.methods.forEach(function (method){
            if (method.sample_code !== null) {
                $method = $(method_template_sample(method));
            } else {
                $method = $(method_template(method));
            }
            $accordion.append($method);
        });
        
        $accordion.accordion({collapsible: true, heightStyle: "content" });
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
    });
};