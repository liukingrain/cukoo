Cukoo = {}

Cukoo.Popup = {
    is_content: false,
    is_loading: false,
    
    callbacks: [],
    
    init: function () {
        var self = this,
            parentElement = jQuery('body');
        
        self.bindEvents(parentElement);
    },
    
    open: function (triggerElement) {
        var self = this,
            popup_url = triggerElement.attr('href') || triggerElement.data('url');
    
        if (popup_url) {
            self.loading();
            
            jQuery.ajax({
                type: 'GET',
                url: popup_url,
                statusCode: {
                  200: function (response) {

                        },
                    401: function (response) {
                      console.log(response, 'sadfsdfsd');
                    }
                },
                success: function (content, status, response) {
                    self.fill(content);
                    window.txhr = response;
                    if (typeof successCallback === 'function') {
                        successCallback();
                    }
                },
                error: function (response, status) {
                    self.fill(self.error());
                    window.txhr = response;
                    if (typeof errorCallback === 'function') {
                        errorCallback();
                    }
                }
            });
        }
    },
    
    close: function () {
        var self = this,
            popupWindow = self.getPopupWindow();
        
        popupWindow.parents('.popover-overlay').remove();
        
        self.is_content = true;
    },
    
    submit: function (triggerElement, options) {
        var self = this,
            formElement = triggerElement.parents('form').eq(0),
            form_url, form_data, form_method;
    
        if (formElement.get(0)) {
            self.loading();
            
            form_url = formElement.attr('action');
            form_data = formElement.serialize();
            form_method = formElement.attr('method');
            
            if (typeof options.beforeSubmitCallback === 'function') {
                options.beforeSubmitCallback();
            }
            
            jQuery.ajax({
                type: form_method,
                url: form_url,
                data: form_data,
                success: function (content, status, response) {
                  console.log(options);
                    if (typeof options.successCallback === 'function') {
                        options.successCallback();
                    } else {
                        //self.close();
                        console.log('ok');
                        //window.location.reload();
                    }
                }
                ,
                error: function (response, status) {
                    if (typeof options.errorCallback === 'function') {
                        options.errorCallback(response.responseText);
                    }
                }
            });
        }
    },
    
    fill: function (content) {
        var self = this,
            popupWindow = self.getPopupWindow();
        
        popupWindow.find('*').remove();
        popupWindow.append(content);
        
        self.bindEvents(popupWindow);
        
        self.finish();
        Cukoo.Forms.initialize(popupWindow);
    },
    
    finish: function () {
        var self = this,
            popupWindow = self.getPopupWindow();
    
        self.is_content = true;
        self.is_loading = false;
        popupWindow.removeClass('loading');
    },
    
    loading: function () {
        var self = this,
            popupWindow = self.getPopupWindow();
    
        if (!self.is_content) {
            popupWindow.addClass('loading');
        }
        self.is_loading = true;
    },
    
    getPopupWindow: function () {
        var popupWindow = jQuery('.popup_window'),
            popupClose, popupOverlay, popupWrapper, popupContent;
        
        if (!popupWindow.get(0)) {
            popupOverlay = jQuery('<div>').addClass('popover-overlay');
            popupWrapper = jQuery('<div>').addClass('popup-wrapper');
            popupContent = jQuery('<div>').addClass('popup-content');
            popupWindow = jQuery('<div>').addClass('popup_window').addClass('content');
            popupClose = jQuery('<span>').addClass('close').addClass('popup_close').html('&nbsp;');
            popupContent.append(popupClose);
            popupContent.append(popupWindow);
            
            popupOverlay.append(popupWrapper);
            popupWrapper.append(popupContent);
            popupOverlay.show();
            
            popupClose.on('click', function(){
                Cukoo.Popup.close();
            });
        }
        
        jQuery('body').prepend(popupOverlay);
        
        return popupWindow;
    },
    
    bindEvents: function (parentElement) {
        var self = this;
        
        parentElement.find('.open_popup').on('click', function (event) {
            self.stopEvents(event);
            self.open(jQuery(this));
        });
        
        parentElement.find('.submit_popup').on('click', function (event) {
            self.stopEvents(event);
            var triggerElement = jQuery(this),
                formElement = triggerElement.parents('form'),
                cname = formElement.data('callbacks-name'),
                formCallbacks = self.callbacks[cname] || {},
                successCallback = formCallbacks.successCallback || null,
                errorCallback = formCallbacks.errorCallback || null,
                beforeSubmitCallback = formCallbacks.beforeSubmitCallback || null;
            
            self.submit(triggerElement, {
                'successCallback': successCallback,
                'errorCallback': errorCallback,
                'beforeSubmitCallback': beforeSubmitCallback
            });
        });
    },
    
    stopEvents: function (event) {
        event.stopPropagation();
        event.preventDefault();
        event.returnValue = false;
        return event;
    },
    
    error: function () {
        return '<p>Usługa chwilowo niedostępna.</p><p>Spróbuj za chwilę.</p>';
    }
};

jQuery(document).ready(function(){
    Cukoo.Popup.init();
});

Cukoo.Forms = {
    initialize: function(parentElement) {
        Cukoo.Forms.Login.init(parentElement);
        Cukoo.Forms.Signup.init(parentElement);
    }
};

Cukoo.Forms.Login = {
    init: function(parentElement) {
        var loginForm = parentElement.find('#new_user'), cname = '#login', callbacks = {};
        
        if (loginForm.get(0)) {          
            loginForm.data('callbacks-name', cname);
            
            callbacks.errorCallback = function (errorMessage) {
                var errorElement = loginForm.find('.error');
                if (!errorElement.size()) {
                  errorElement = jQuery('<div>').addClass('error');
                }                
                loginForm.prepend(errorElement.html(errorMessage));// jQuery('body').append('<div style="width:50px;height:50px;background:red"></div>');
            }
            
            callbacks.beforeSubmitCallback = function () {
              loginForm.find('.error').remove();
            }
            
            Cukoo.Popup.callbacks[cname] = callbacks;
        }
    }
};

Cukoo.Forms.Signup = {
  init: function(parentElement) {
    var form = parentElement.find('#signup'), cname = '#signup', callbacks = {};
    
    if (form.get(0)) {          
        form.data('callbacks-name', cname);
        
        callbacks.successCallback = function() {
          
        }
        
        callbacks.errorCallback = function (errorMessage) {
            var errorElement = form.find('.error');
            if (!errorElement.size()) {
              errorElement = jQuery('<div>').addClass('error');
            }                
            form.prepend(errorElement.html(errorMessage));// jQuery('body').append('<div style="width:50px;height:50px;background:red"></div>');
        }
        
        callbacks.beforeSubmitCallback = function () {
          form.find('.error').remove();
        }
        
        Cukoo.Popup.callbacks[cname] = callbacks;
    }
  }
}