// Function to add a new info message to localStorage
function addInfo(newMessage) {
    let info = [];
    //Read existing messages
    if (localStorage.getItem('toast_info')) {
        info = JSON.parse(localStorage.getItem('toast_info'));
    }

    if (newMessage) {
        info.push(newMessage);
        localStorage.setItem('toast_info', JSON.stringify(info));
    }
}

// Function to add a new success message to localStorage
function addSuccess(newMessage) {
    let success = [];
    //Read existing messages
    if (localStorage.getItem('toast_success')) {
        success = JSON.parse(localStorage.getItem('toast_success'));
    }

    if (newMessage) {
        success.push(newMessage);
        localStorage.setItem('toast_success', JSON.stringify(success));
    }
}

// Function to add a new warning message to localStorage
function addWarning(newMessage) {
    let warning = [];
    //Read existing messages
    if (localStorage.getItem('toast_warning')) {
        warning = JSON.parse(localStorage.getItem('toast_warning'));
    }

    if (newMessage) {
        warning.push(newMessage);
        localStorage.setItem('toast_warning', JSON.stringify(warning));
    }
}

// Function to add a new error message to localStorage
function addError(newMessage) {
    let error = [];
    //Read existing messages
    if (localStorage.getItem('toast_error')) {
        error = JSON.parse(localStorage.getItem('toast_error'));
    }

    if (newMessage) {
        error.push(newMessage);
        localStorage.setItem('toast_error', JSON.stringify(error));
    }
}

//export function toast(type, message) {
//    const toastFunctions = {
//        Info: addInfo,
//        Success: addSuccess,
//        Warning: addWarning,
//        Error: addError,
//    };
//
//    const showToast = toastFunctions[type];
//    showToast(message);
//}

export function toast({ info = '', success = '', warning = '', error = '' }) {
    if (info) {
        addInfo(info);
    }
    if (success) {
        addSuccess(success);
    }
    if (warning) {
        addWarning(warning);
    }
    if (error) {
        addError(error);
    }
}



