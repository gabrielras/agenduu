window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
	add: function (element, settings, message) {
		console.log(element[0])
		// custom add code here
		let form = $(element[0].form);
		let for_id = element.attr('id');

		// if (element.data('valid') !== false) {

			if (form.find("label.error[for='" + for_id + "']")[0] == null) {
				// form.find("label[for='" + for_id + "']").addClass('is-invalid').attr('data-error', message);
				element.removeClass("is-valid");
				element.removeClass("validate");
				element.addClass("invalid");
				element.addClass('is-invalid');
				element.focus();

				let el = form.find("label[for='" + for_id + "']").parent().find('div');
				el.find('.invalid-feedback').remove();
				el.append(`<div class='invalid-feedback'> ${message} </div>`);
			}
		// }
		//
		// return form.find("label.error[for='" + for_id + "']").attr('data-error', message);
	},

	remove: function (element, settings) {
		console.log(element[0])

		let form = $(element[0].form);

		if (element.hasClass('is-invalid')) {
			let for_id = element.attr('id');
			form.find("label[for='" + for_id + "']").removeClass('is-invalid').removeAttr('data-error');
      
			element.addClass("is-valid");
			element.addClass("validate");
			element.removeClass("invalid");
			element.removeClass('is-invalid');
			element.parent().find('.invalid-feedback').remove();
		}
		return element;
	}
}