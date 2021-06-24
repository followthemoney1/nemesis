"use strict";
exports.__esModule = true;
exports.converter = void 0;
///DATA
exports.converter = function () { return ({
    toFirestore: function (data) { return data; },
    fromFirestore: function (snap) { return snap.data(); }
}); };
