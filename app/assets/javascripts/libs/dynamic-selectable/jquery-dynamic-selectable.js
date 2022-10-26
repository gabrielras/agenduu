(function() {
  let DynamicSelectable;

  $.fn.extend({
    dynamicSelectable: function() {
      return $(this).each(function(i, el) {
        return new DynamicSelectable($(el));
      });
    }
  });

  DynamicSelectable = (function() {
    function DynamicSelectable($select) {
      this.init($select);
    }

    DynamicSelectable.prototype.init = function($select) {
      this.urlTemplate = $select.data('dynamicSelectableUrl');
      this.$targetSelect = $($select.data('dynamicSelectableTarget'));
      return $select.on('change', (function(_this) {
        return function() {
          let url;
          _this.clearTarget();
          url = _this.constructUrl($select.val());
          if (url) {
            return $.getJSON(url, function(data) {
              $.each(data, function(index, el) {
                if (el.description){
                  return _this.$targetSelect.append(
                    `<option value='${el.id}'> ${el.description} </option>`
                  );
                }
              });
              return _this.reinitializeTarget();
            });
          } else {
            return _this.reinitializeTarget();
          }
        }
      })(this));
    };

    DynamicSelectable.prototype.reinitializeTarget = function() {
      this.$targetSelect.selectpicker();
      return this.$targetSelect.trigger('change');
    };

    DynamicSelectable.prototype.clearTarget = function() {
      this.$targetSelect.selectpicker('destroy');
      return this.$targetSelect.html('<option></option>');
    };

    DynamicSelectable.prototype.constructUrl = function(id) {
      if (id && id !== '') {
        // size = this.urlTemplate.length;
        index = this.urlTemplate.indexOf('_id');
        if (this.urlTemplate.substr(index, 3) === '_id') {
          return this.urlTemplate.replace(/:.+_id/, id);
        } else {
          return this.urlTemplate.replace(/:.+/, id);
        }
      }
    };

    return DynamicSelectable;

  })();

}).call(this);
