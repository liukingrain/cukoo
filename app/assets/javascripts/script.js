Cukoo = {}

Cukoo.Popup = {
    is_content: false,
    
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
        
        popupWindow.remove();
        
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
                statusCode: {
                  200: function (response) {

                        },
                    401: function (response) {
                      console.log(response, 'sadfsdfsd');
                      self.fill(response.responseText);
                    }
                },
                success: function (content, status, response) {
                    self.fill(content);
                    console.log(status);
                    if (typeof options.successCallback === 'function') {
                        options.successCallback();
                    }
                }
                ,
                error: function (response, status) {
                    self.fill(self.error());
                    console.log(response.status);
                    if (typeof options.errorCallback === 'function') {
                        options.errorCallback();
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
        popupWindow.removeClass('loading');
    },
    
    loading: function () {
        var self = this,
            popupWindow = self.getPopupWindow();
    
        if (!self.is_content) {
            popupWindow.addClass('loading');
        }
    },
    
    getPopupWindow: function () {
        var popupWindow = jQuery('.popup_window'),
            popupClose, popupOverlay, popupWrapper, popupContent;
        
        if (!popupWindow.get(0)) {
            popupOverlay = jQuery('<div>').addClass('popover-overlay');
            popupWrapper = jQuery('<div>').addClass('popup-wrapper');
            popupContent = jQuery('<div>').addClass('popup-content');
            popupWindow = jQuery('<div>').addClass('popup_window').addClass('content');
            popupClose = jQuery('<span>').addClass('close').addClass('popup_close').html('x');
            popupContent.append(popupClose);
            popupContent.append(popupWindow);
            
            popupOverlay.append(popupWrapper);
            popupWrapper.append(popupContent);
            popupOverlay.show();
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
            var triggerElement = jQuery(this),
                formElement = triggerElement.parents('form'),
                successCallback = formElement.get(0).successCallback || null,
                errorCallback = formElement.get(0).errorCallback || null,
                beforeSubmitCallback = formElement.get(0).beforeSubmitCallback || null;
            
            self.stopEvents(event);
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
    jQuery('body').on('click', 'popup_close', function(){
      console.log('hdshfhdsbfhdhfbdhdgfhdfhgdhfbghdfbghfghfgfghdfbgjfgjdfhgj');
      Cooko.Popup.close();
    });
});

Cukoo.Forms = {
    initialize: function(parentElement) {
        Cukoo.Forms.Login.init(parentElement);
    }
};

Cukoo.Forms.Login = {
    init: function(parentElement) {
        var loginForm = parentElement.find('#login');
        if (loginForm.get(0)) {
            loginForm.get(0).successCallback = function () {
                Cukoo.Popup.close();
                jQuery('body').append('<div style="width:50px;height:50px;background:red"></div>');
            }
        }
    }
};