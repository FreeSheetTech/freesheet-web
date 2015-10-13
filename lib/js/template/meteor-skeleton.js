Package = (typeof Package != 'undefined') ? Package : {};
Meteor = (typeof Meteor != 'undefined') ? Meteor : {
    isClient: true,
    _setImmediate: function(func) { setTimeout(func, 0);  },
    _inherits: function (Child, Parent) {
        for (var key in Parent) {
            if (_.has(Parent, key))
                Child[key] = Parent[key];
        }

        var Middle = function () {
            this.constructor = Child;
        };
        Middle.prototype = Parent.prototype;
        Child.prototype = new Middle();
        Child.__super__ = Parent.prototype;
        return Child;
    }
};
