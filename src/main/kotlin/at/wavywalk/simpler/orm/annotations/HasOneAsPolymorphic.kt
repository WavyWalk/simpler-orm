package at.wavywalk.simpler.orm.annotations

import kotlin.reflect.KClass

@Target(AnnotationTarget.FIELD)
annotation class HasOneAsPolymorphic(
        val model: KClass<*>,
        val fieldOnThis: String,
        val fieldOnThat: String,
        val polymorphicTypeField: String,
        val onDelete: String = "none"
)