<#-- @ftlvariable name="" type="at.wavywalk.simpler.orm.templateDataModels.model.ModelDataModel" -->
<#-- @ftlvariable name="ab" type="at.wavywalk.simpler.orm.templateDataModels.model.AssociationBean" -->
package ${packagesBean.baseGenerated}

import java.sql.ResultSet
import ${packagesBean.model}

object ${modelClass}FieldsAccessor {

    val fromResultSetRowFieldSetters: HashMap
        <
            String,
            (model: ${modelClass}, resultSet: ResultSet, cursorPosition: Int)-> Unit
        > = hashMapOf(

        <#list fieldBeans as fieldBean>
        "${fieldBean.actualDbFieldName}" to {
            model, resultSet, cursorPosition ->
            <#if fieldBean.nonNullableType == "Long">
            val intermediaryValue = resultSet.get${fieldBean.nonNullableType}(cursorPosition)
            if (resultSet.wasNull()) {
                model.${fieldBean.property} = null
            } else {
                model.${fieldBean.property} = intermediaryValue
            }
            <#elseif fieldBean.nonNullableType == "Int">
            val intermediaryValue = resultSet.get${fieldBean.nonNullableType}(cursorPosition)
            if (resultSet.wasNull()) {
                model.${fieldBean.property} = null
            } else {
                model.${fieldBean.property} = intermediaryValue
            }
            <#else>
            model.${fieldBean.property} = resultSet.get${fieldBean.nonNullableType}(cursorPosition)
            </#if>
        }<#sep>,</#sep>
        </#list>

    )

}
