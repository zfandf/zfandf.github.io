// 计数器
var counterModule = (function() {
    var counter = 0;
    return {
        add: function() {
            return ++counter;
        },
        sub: function() {
            return --counter;
        },
        reset: function() {
            counter = 0;
            return counter;
        }
    };
})();

// 用法

// 增加计数器
counterModule.add();
counterModule.add();
counterModule.add();

// 重置计数器
counterModule.reset();