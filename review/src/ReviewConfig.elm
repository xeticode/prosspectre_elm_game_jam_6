module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import Docs.ReviewAtDocs
import NoDebug.Log
import NoForbiddenWords
import NoDebug.TodoOrToString
import NoExposingEverything
import UseMemoizedLazyLambda
import NoImportingEverything
import NoMissingTypeAnnotation
-- import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoSimpleLetBody
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify
import NoRedundantConcat
import NoRedundantCons
import NoSinglePatternCase
import NoSinglePatternCase
import NoBooleanCase
import NoUnoptimizedRecursion
import NoUnapprovedLicense
import NoUselessSubscriptions
import NoRecursiveUpdate
import NoMissingSubscriptionsCall
import NoDeprecated
import NoConfusingPrefixOperator
import NoInvalidRGBValues


config : List Rule
config =
    List.map
        (Rule.ignoreErrorsForDirectories
            [ "tests/"
            , "ui-components/"
            , "scene_navigation"
            , "device_views"
            , "src/CardinalityGQL"
            ]
        )
        [ Docs.ReviewAtDocs.rule
        , NoDebug.Log.rule
        , NoDebug.TodoOrToString.rule
        , NoSimpleLetBody.rule
        , Simplify.rule Simplify.defaults
        , NoInvalidRGBValues.rule
        , NoConfusingPrefixOperator.rule
        , NoDeprecated.rule NoDeprecated.defaults
        , NoImportingEverything.rule []
        , NoExposingEverything.rule
        , NoMissingTypeAnnotation.rule
        -- , NoMissingTypeAnnotationInLetIn.rule
        , NoMissingTypeExpose.rule
        , NoPrematureLetComputation.rule
        , NoUnused.CustomTypeConstructors.rule []
        , NoUnused.CustomTypeConstructorArgs.rule
        , NoUnused.Dependencies.rule
        , NoUnused.Exports.rule
        , NoUnused.Parameters.rule
        , NoUnused.Patterns.rule
        , NoUnused.Variables.rule
        , NoMissingSubscriptionsCall.rule
        , NoRecursiveUpdate.rule
        , NoUselessSubscriptions.rule
        , UseMemoizedLazyLambda.rule
        , NoUnapprovedLicense.rule
            { allowed = [ "BSD-3-Clause", "MIT", "Apache-2.0" ]
            , forbidden = [ "GPL-3.0-only", "GPL-3.0-or-later", "MPL-2.0" ]
            }
        , NoUnoptimizedRecursion.rule
            (NoUnoptimizedRecursion.optOutWithComment "IGNORE TCO")
        , NoBooleanCase.rule
        , NoSinglePatternCase.rule
            NoSinglePatternCase.fixInArgument
        , NoRedundantCons.rule
        , NoRedundantConcat.rule
        , NoForbiddenWords.rule -- Comment Anchors that might need to stop a pull request
            [ "TODO"
            , "FIXME"
            , "REVIEW"
            ]
        ]