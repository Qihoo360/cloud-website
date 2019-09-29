/*!
scroll-behavior-polyfill 2.0.6
license: MIT (https://github.com/wessberg/scroll-behavior-polyfill/blob/master/LICENSE.md)
Copyright © 2019 Frederik Wessberg <frederikwessberg@hotmail.com>
*/(function(){'use strict';var SUPPORTS_SCROLL_BEHAVIOR="scrollBehavior"in document.documentElement.style;/*! *****************************************************************************
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at http://www.apache.org/licenses/LICENSE-2.0
THIS CODE IS PROVIDED ON AN *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
MERCHANTABLITY OR NON-INFRINGEMENT.
See the Apache Version 2.0 License for specific language governing permissions
and limitations under the License.
***************************************************************************** */var __assign=function(){__assign=Object.assign||function __assign(t){for(var s,i=1,n=arguments.length;i<n;i++){s=arguments[i];for(var p in s)if(Object.prototype.hasOwnProperty.call(s,p))t[p]=s[p];}
return t;};return __assign.apply(this,arguments);};function __read(o,n){var m=typeof Symbol==="function"&&o[Symbol.iterator];if(!m)return o;var i=m.call(o),r,ar=[],e;try{while((n===void 0||n-->0)&&!(r=i.next()).done)ar.push(r.value);}
catch(error){e={error:error};}
finally{try{if(r&&!r.done&&(m=i["return"]))m.call(i);}
finally{if(e)throw e.error;}}
return ar;}
var styleDeclarationPropertyName="scrollBehavior";var styleAttributePropertyName="scroll-behavior";var styleAttributePropertyNameRegex=new RegExp(styleAttributePropertyName+":\\s*([^;]*)");function getScrollBehavior(inputTarget,options){if(options!=null&&options.behavior==="smooth")
return "smooth";var target="style"in inputTarget?inputTarget:document.scrollingElement!=null?document.scrollingElement:document.documentElement;var value;if("style"in target){var scrollBehaviorPropertyValue=target.style[styleDeclarationPropertyName];if(scrollBehaviorPropertyValue!=null&&scrollBehaviorPropertyValue!==""){value=scrollBehaviorPropertyValue;}}
if(value==null){var attributeValue=target.getAttribute("scroll-behavior");if(attributeValue!=null&&attributeValue!==""){value=attributeValue;}}
if(value==null){var styleAttributeValue=target.getAttribute("style");if(styleAttributeValue!=null&&styleAttributeValue.includes(styleAttributePropertyName)){var match=styleAttributeValue.match(styleAttributePropertyNameRegex);if(match!=null){var _a=__read(match,2),behavior=_a[1];if(behavior!=null&&behavior!==""){value=behavior;}}}}
if(value==null){var computedStyle=getComputedStyle(target);var computedStyleValue=computedStyle.getPropertyValue("scrollBehavior");if(computedStyleValue!=null&&computedStyleValue!==""){value=computedStyleValue;}}
return value;}
var HALF=0.5;function ease(k){return HALF*(1-Math.cos(Math.PI*k));}
var SCROLL_TIME=15000;function smoothScroll(options){var startTime=options.startTime,startX=options.startX,startY=options.startY,endX=options.endX,endY=options.endY,method=options.method;var timeLapsed=0;var distanceX=endX-startX;var distanceY=endY-startY;var speed=Math.max(Math.abs((distanceX/1000)*SCROLL_TIME),Math.abs((distanceY/1000)*SCROLL_TIME));requestAnimationFrame(function animate(timestamp){timeLapsed+=timestamp-startTime;var percentage=Math.max(0,Math.min(1,speed===0?0:timeLapsed/speed));var positionX=Math.floor(startX+distanceX*ease(percentage));var positionY=Math.floor(startY+distanceY*ease(percentage));method(positionX,positionY);if(positionX!==endX||positionY!==endY){requestAnimationFrame(animate);}});}
function now(){if("performance"in window)
return performance.now();return Date.now();}
var ELEMENT_ORIGINAL_SCROLL=Element.prototype.scroll;var WINDOW_ORIGINAL_SCROLL=window.scroll;var ELEMENT_ORIGINAL_SCROLL_BY=Element.prototype.scrollBy;var WINDOW_ORIGINAL_SCROLL_BY=window.scrollBy;var ELEMENT_ORIGINAL_SCROLL_TO=Element.prototype.scrollTo;var WINDOW_ORIGINAL_SCROLL_TO=window.scrollTo;function elementPrototypeScrollFallback(x,y){this.__adjustingScrollPosition=true;this.scrollLeft=x;this.scrollTop=y;delete this.__adjustingScrollPosition;}
function elementPrototypeScrollToFallback(x,y){return elementPrototypeScrollFallback.call(this,x,y);}
function elementPrototypeScrollByFallback(x,y){this.__adjustingScrollPosition=true;this.scrollLeft+=x;this.scrollTop+=y;delete this.__adjustingScrollPosition;}
function getOriginalScrollMethodForKind(kind,element){switch(kind){case "scroll":if(element instanceof Element){if(ELEMENT_ORIGINAL_SCROLL!=null){return ELEMENT_ORIGINAL_SCROLL;}
else{return elementPrototypeScrollFallback;}}
else{return WINDOW_ORIGINAL_SCROLL;}
case "scrollBy":if(element instanceof Element){if(ELEMENT_ORIGINAL_SCROLL_BY!=null){return ELEMENT_ORIGINAL_SCROLL_BY;}
else{return elementPrototypeScrollByFallback;}}
else{return WINDOW_ORIGINAL_SCROLL_BY;}
case "scrollTo":if(element instanceof Element){if(ELEMENT_ORIGINAL_SCROLL_TO!=null){return ELEMENT_ORIGINAL_SCROLL_TO;}
else{return elementPrototypeScrollToFallback;}}
else{return WINDOW_ORIGINAL_SCROLL_TO;}}}
function getSmoothScrollOptions(element,x,y,kind){var startTime=now();if(!(element instanceof Element)){var scrollX_1=window.scrollX,pageXOffset_1=window.pageXOffset,scrollY_1=window.scrollY,pageYOffset_1=window.pageYOffset;var startX=scrollX_1==null||scrollX_1===0?pageXOffset_1:scrollX_1;var startY=scrollY_1==null||scrollY_1===0?pageYOffset_1:scrollY_1;return{startTime:startTime,startX:startX,startY:startY,endX:Math.floor(kind==="scrollBy"?startX+x:x),endY:Math.floor(kind==="scrollBy"?startY+y:y),method:getOriginalScrollMethodForKind("scrollTo",window).bind(window)};}
else{var scrollLeft=element.scrollLeft,scrollTop=element.scrollTop;var startX=scrollLeft;var startY=scrollTop;return{startTime:startTime,startX:startX,startY:startY,endX:Math.floor(kind==="scrollBy"?startX+x:x),endY:Math.floor(kind==="scrollBy"?startY+y:y),method:getOriginalScrollMethodForKind("scrollTo",element).bind(element)};}}
function ensureNumeric(value){if(value==null)
return 0;else if(typeof value==="number"){return value;}
else if(typeof value==="string"){return parseFloat(value);}
else{return 0;}}
function isScrollToOptions(value){return value!=null&&typeof value==="object";}
function handleScrollMethod(element,kind,optionsOrX,y){onScrollWithOptions(getScrollToOptionsWithValidation(optionsOrX,y),element,kind);}
function onScrollWithOptions(options,element,kind){var behavior=getScrollBehavior(element,options);if(behavior==null||behavior==="auto"){getOriginalScrollMethodForKind(kind,element).call(element,options.left,options.top);}
else{smoothScroll(getSmoothScrollOptions(element,options.left,options.top,kind));}}
function normalizeScrollCoordinates(x,y){return{left:ensureNumeric(x),top:ensureNumeric(y)};}
function getScrollToOptionsWithValidation(optionsOrX,y){if(y===undefined&&!isScrollToOptions(optionsOrX)){throw new TypeError("Failed to execute 'scroll' on 'Element': parameter 1 ('options') is not an object.");}
if(!isScrollToOptions(optionsOrX)){return __assign({},normalizeScrollCoordinates(optionsOrX,y),{behavior:"auto"});}
else{return __assign({},normalizeScrollCoordinates(optionsOrX.left,optionsOrX.top),{behavior:optionsOrX.behavior==null?"auto":optionsOrX.behavior});}}
function patchElementScroll(){Element.prototype.scroll=function(optionsOrX,y){handleScrollMethod(this,"scroll",optionsOrX,y);};}
function patchElementScrollBy(){Element.prototype.scrollBy=function(optionsOrX,y){handleScrollMethod(this,"scrollBy",optionsOrX,y);};}
function patchElementScrollTo(){Element.prototype.scrollTo=function(optionsOrX,y){handleScrollMethod(this,"scrollTo",optionsOrX,y);};}
function patchWindowScroll(){window.scroll=function(optionsOrX,y){handleScrollMethod(this,"scroll",optionsOrX,y);};}
function patchWindowScrollBy(){window.scrollBy=function(optionsOrX,y){handleScrollMethod(this,"scrollBy",optionsOrX,y);};}
function patchWindowScrollTo(){window.scrollTo=function(optionsOrX,y){handleScrollMethod(this,"scrollTo",optionsOrX,y);};}
function getParent(currentElement){if("nodeType"in currentElement&&currentElement.nodeType===1){return currentElement.parentNode;}
if("ShadowRoot"in window&&currentElement instanceof window.ShadowRoot){return currentElement.host;}
else if(currentElement===document){return window;}
else if(currentElement instanceof Node)
return currentElement.parentNode;return null;}
var scrollingElement=document.scrollingElement!=null?document.scrollingElement:document.documentElement;function canOverflow(overflow){return overflow!=="visible"&&overflow!=="clip";}
function isScrollable(element){if(element.clientHeight<element.scrollHeight||element.clientWidth<element.scrollWidth){var style=getComputedStyle(element,null);return canOverflow(style.overflowY)||canOverflow(style.overflowX);}
return false;}
function findNearestAncestorsWithScrollBehavior(target){var currentElement=target;while(currentElement!=null){var behavior=getScrollBehavior(currentElement);if(behavior!=null&&(currentElement===scrollingElement||isScrollable(currentElement))){return[currentElement,behavior];}
var parent_1=getParent(currentElement);currentElement=parent_1;}
currentElement=target;while(currentElement!=null){if(currentElement===scrollingElement||isScrollable(currentElement)){return[currentElement,"auto"];}
var parent_2=getParent(currentElement);currentElement=parent_2;}
return[scrollingElement,"auto"];}
function findNearestRoot(target){var currentElement=target;while(currentElement!=null){if("ShadowRoot"in window&&currentElement instanceof window.ShadowRoot){return currentElement;}
var parent_1=getParent(currentElement);if(parent_1===currentElement){return document;}
currentElement=parent_1;}
return document;}
var ID_WITH_LEADING_DIGIT_REGEXP=/^#\d/;function catchNavigation(){window.addEventListener("click",function(e){if(!e.isTrusted||!(e.target instanceof HTMLAnchorElement))
return;var hrefAttributeValue=e.target.getAttribute("href");if(hrefAttributeValue==null||!hrefAttributeValue.startsWith("#")){return;}
var root=findNearestRoot(e.target);var elementMatch=hrefAttributeValue.match(ID_WITH_LEADING_DIGIT_REGEXP)!=null?root.getElementById(hrefAttributeValue.slice(1)):root.querySelector(hrefAttributeValue);if(elementMatch==null)
return;var _a=__read(findNearestAncestorsWithScrollBehavior(elementMatch),2),ancestorWithScrollBehavior=_a[0],behavior=_a[1];if(behavior!=="smooth")
return;e.preventDefault();ancestorWithScrollBehavior.scrollTo({behavior:behavior,top:elementMatch.offsetTop,left:elementMatch.offsetLeft});});}
var ELEMENT_ORIGINAL_SCROLL_INTO_VIEW=Element.prototype.scrollIntoView;function alignNearest(scrollingEdgeStart,scrollingEdgeEnd,scrollingSize,scrollingBorderStart,scrollingBorderEnd,elementEdgeStart,elementEdgeEnd,elementSize){if((elementEdgeStart<scrollingEdgeStart&&elementEdgeEnd>scrollingEdgeEnd)||(elementEdgeStart>scrollingEdgeStart&&elementEdgeEnd<scrollingEdgeEnd)){return 0;}
if((elementEdgeStart<=scrollingEdgeStart&&elementSize<=scrollingSize)||(elementEdgeEnd>=scrollingEdgeEnd&&elementSize>=scrollingSize)){return elementEdgeStart-scrollingEdgeStart-scrollingBorderStart;}
if((elementEdgeEnd>scrollingEdgeEnd&&elementSize<scrollingSize)||(elementEdgeStart<scrollingEdgeStart&&elementSize>scrollingSize)){return elementEdgeEnd-scrollingEdgeEnd+scrollingBorderEnd;}
return 0;}
function computeScrollIntoView(target,scroller,options){var block=options.block,inline=options.inline;var scrollingElement=document.scrollingElement||document.documentElement;var viewportWidth=window.visualViewport!=null?visualViewport.width:innerWidth;var viewportHeight=window.visualViewport!=null?visualViewport.height:innerHeight;var viewportX=window.scrollX!=null?window.scrollX:window.pageXOffset;var viewportY=window.scrollY!=null?window.scrollY:window.pageYOffset;var _a=target.getBoundingClientRect(),targetHeight=_a.height,targetWidth=_a.width,targetTop=_a.top,targetRight=_a.right,targetBottom=_a.bottom,targetLeft=_a.left;var targetBlock=block==="start"||block==="nearest"?targetTop:block==="end"?targetBottom:targetTop+targetHeight/2;var targetInline=inline==="center"?targetLeft+targetWidth/2:inline==="end"?targetRight:targetLeft;var _b=scroller.getBoundingClientRect(),height=_b.height,width=_b.width,top=_b.top,right=_b.right,bottom=_b.bottom,left=_b.left;var frameStyle=getComputedStyle(scroller);var borderLeft=parseInt(frameStyle.borderLeftWidth,10);var borderTop=parseInt(frameStyle.borderTopWidth,10);var borderRight=parseInt(frameStyle.borderRightWidth,10);var borderBottom=parseInt(frameStyle.borderBottomWidth,10);var blockScroll=0;var inlineScroll=0;var scrollbarWidth="offsetWidth"in scroller?scroller.offsetWidth-scroller.clientWidth-borderLeft-borderRight:0;var scrollbarHeight="offsetHeight"in scroller?scroller.offsetHeight-scroller.clientHeight-borderTop-borderBottom:0;if(scrollingElement===scroller){if(block==="start"){blockScroll=targetBlock;}
else if(block==="end"){blockScroll=targetBlock-viewportHeight;}
else if(block==="nearest"){blockScroll=alignNearest(viewportY,viewportY+viewportHeight,viewportHeight,borderTop,borderBottom,viewportY+targetBlock,viewportY+targetBlock+targetHeight,targetHeight);}
else{blockScroll=targetBlock-viewportHeight/2;}
if(inline==="start"){inlineScroll=targetInline;}
else if(inline==="center"){inlineScroll=targetInline-viewportWidth/2;}
else if(inline==="end"){inlineScroll=targetInline-viewportWidth;}
else{inlineScroll=alignNearest(viewportX,viewportX+viewportWidth,viewportWidth,borderLeft,borderRight,viewportX+targetInline,viewportX+targetInline+targetWidth,targetWidth);}
blockScroll=Math.max(0,blockScroll+viewportY);inlineScroll=Math.max(0,inlineScroll+viewportX);}
else{if(block==="start"){blockScroll=targetBlock-top-borderTop;}
else if(block==="end"){blockScroll=targetBlock-bottom+borderBottom+scrollbarHeight;}
else if(block==="nearest"){blockScroll=alignNearest(top,bottom,height,borderTop,borderBottom+scrollbarHeight,targetBlock,targetBlock+targetHeight,targetHeight);}
else{blockScroll=targetBlock-(top+height/2)+scrollbarHeight/2;}
if(inline==="start"){inlineScroll=targetInline-left-borderLeft;}
else if(inline==="center"){inlineScroll=targetInline-(left+width/2)+scrollbarWidth/2;}
else if(inline==="end"){inlineScroll=targetInline-right+borderRight+scrollbarWidth;}
else{inlineScroll=alignNearest(left,right,width,borderLeft,borderRight+scrollbarWidth,targetInline,targetInline+targetWidth,targetWidth);}
var scrollLeft=scroller.scrollLeft,scrollTop=scroller.scrollTop;blockScroll=Math.max(0,Math.min(scrollTop+blockScroll,scroller.scrollHeight-height+scrollbarHeight));inlineScroll=Math.max(0,Math.min(scrollLeft+inlineScroll,scroller.scrollWidth-width+scrollbarWidth));}
return{top:blockScroll,left:inlineScroll};}
function patchElementScrollIntoView(){Element.prototype.scrollIntoView=function(arg){var normalizedOptions=arg==null||arg===true?{block:"start",inline:"nearest"}:arg===false?{block:"end",inline:"nearest"}:arg;var _a=__read(findNearestAncestorsWithScrollBehavior(this),2),ancestorWithScroll=_a[0],ancestorWithScrollBehavior=_a[1];var behavior=normalizedOptions.behavior!=null?normalizedOptions.behavior:ancestorWithScrollBehavior;if(behavior!=="smooth"){if(ELEMENT_ORIGINAL_SCROLL_INTO_VIEW!=null){ELEMENT_ORIGINAL_SCROLL_INTO_VIEW.call(this,normalizedOptions);}
else{var _b=computeScrollIntoView(this,ancestorWithScroll,normalizedOptions),top_1=_b.top,left=_b.left;getOriginalScrollMethodForKind("scrollTo",this).call(this,left,top_1);}
return;}
ancestorWithScroll.scrollTo(__assign({behavior:behavior},computeScrollIntoView(this,ancestorWithScroll,normalizedOptions)));};}
var ELEMENT_ORIGINAL_SCROLL_TOP_SET_DESCRIPTOR=Object.getOwnPropertyDescriptor(Element.prototype,"scrollTop").set;function patchElementScrollTop(){Object.defineProperty(Element.prototype,"scrollTop",{set:function(scrollTop){if(this.__adjustingScrollPosition){return ELEMENT_ORIGINAL_SCROLL_TOP_SET_DESCRIPTOR.call(this,scrollTop);}
handleScrollMethod(this,"scrollTo",this.scrollLeft,scrollTop);return scrollTop;}});}
var ELEMENT_ORIGINAL_SCROLL_LEFT_SET_DESCRIPTOR=Object.getOwnPropertyDescriptor(Element.prototype,"scrollLeft").set;function patchElementScrollLeft(){Object.defineProperty(Element.prototype,"scrollLeft",{set:function(scrollLeft){if(this.__adjustingScrollPosition){return ELEMENT_ORIGINAL_SCROLL_LEFT_SET_DESCRIPTOR.call(this,scrollLeft);}
handleScrollMethod(this,"scrollTo",scrollLeft,this.scrollTop);return scrollLeft;}});}
function patch(){patchElementScroll();patchElementScrollBy();patchElementScrollTo();patchElementScrollIntoView();patchElementScrollLeft();patchElementScrollTop();patchWindowScroll();patchWindowScrollBy();patchWindowScrollTo();catchNavigation();}
var SUPPORTS_ELEMENT_PROTOTYPE_SCROLL_METHODS="scroll"in Element.prototype&&"scrollTo"in Element.prototype&&"scrollBy"in Element.prototype&&"scrollIntoView"in Element.prototype;if(!SUPPORTS_SCROLL_BEHAVIOR||!SUPPORTS_ELEMENT_PROTOTYPE_SCROLL_METHODS){patch();}}());