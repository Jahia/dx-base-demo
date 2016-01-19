<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%-- TODO: Put date in calendar icon --%>
<%-- TODO: edit mode is not selecting individual events properly --%>


<c:set var="language" value="${currentResource.locale.language}"/>
<fmt:setLocale value="${language}" scope="session"/>

<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="startDate" value="${currentNode.properties['startDate'].time}"/>
<c:set var="endDate" value="${currentNode.properties['endDate']}"/>
<c:set var="location" value="${currentNode.properties['location'].string}"/>
<c:set var="body" value="${currentNode.properties['body'].string}"/>
<c:url var="detailUrl" value="${url.base}${currentNode.path}.html"/>



            <!-- event title -->
            <h2><a href="${detailUrl}">${title}</a></h2>
            <!-- event type, date, location -->
            <ul class="list-inline">
                <c:if test="${not empty currentNode.properties.eventsType}">
                    <li>
                        <button class="btn btn-xs rounded btn-primary" type="button"><fmt:message
                                key='jnt_event.eventsType.${currentNode.properties.eventsType.string}'/></button>
                    </li>
                </c:if>
                <li><fmt:formatDate dateStyle="long" type="date"
                                    value="${currentNode.properties.startDate.time}"/></li>
                <li><i class="fa  fa-map-marker"></i>&nbsp;${location}</li>
            </ul>
            <!-- event body -->
            <p>${body}</p>
            <!-- event people if they exist -->
<%--            <c:if test="${jcr:isNodeType(currentNode, 'jdmix:hasPeople')}">
                <c:set var="boxTitle" value="${currentNode.properties['boxTitle'].string}"/>
                <c:if test="${empty boxTitle}">
                    <c:set var="boxTitle" value="Speakers"/>
                </c:if>
                <ul class="list-inline">
                    <li><i class="fa   fa-users"></i>&nbsp;${boxTitle}:</li>
                    <template:area path="${currentNode.path}/relatedPeople" nodeTypes="jnt:person">
                        <template:param name="subNodesView" value="event"/>
                    </template:area>
                </ul>
            </c:if>
            --%>
            <!-- event categories -->
            <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
            <c:if test="${cat != null}">
                <ul class="list-inline">
                    <c:forEach items="${cat}" var="category">
                        <li><i class="fa fa-tag">&nbsp;${category.node.displayableName}</i></li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${jcr:isNodeType(currentNode, 'jdmix:fileAttachment')}">
                <jcr:nodeProperty node="${currentNode}" name="pdfVersion" var="pdfVersion"/>
                <c:if test="${not empty pdfVersion}">
                    <c:set var="label" value="${currentNode.properties.downloadTitle.string}"/>
                    <c:if test="${empty label}">
                        <c:set var="label"><fmt:message key="jdmix_fileAttachment.label"/></c:set>
                    </c:if>
                    <p>
                    <div><strong>${label} :</strong>
                        <a href="${pdfVersion.node.url}">${pdfVersion.node.name}</a></div>
                    </p>
                </c:if>
            </c:if>
            <%-- set up the back navigation --%>
            <c:set var="parentUrl">javascript:history.back()</c:set>
            <p>
                <a href="${parentUrl}" class="button button-mini button-border button-rounded"><span><i
                        class="icon-line-arrow-left"></i><fmt:message key="jdmix_backLink.back"/></span></a>
            </p>




